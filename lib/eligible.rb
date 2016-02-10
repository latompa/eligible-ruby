require 'cgi'
require 'set'
require 'rubygems'
require 'openssl'
require 'net/https'

require 'rest_client'
require 'multi_json'

require 'eligible/version'
require 'eligible/util'
require 'eligible/json'
require 'eligible/eligible_object'
require 'eligible/api_resource'
require 'eligible/demographic'
require 'eligible/claim'
require 'eligible/enrollment'
require 'eligible/coverage'
require 'eligible/payment'
require 'eligible/x12'
require 'eligible/medicare'
require 'eligible/ticket'
require 'eligible/customer'
require 'eligible/original_signature_pdf'
require 'eligible/payer'

# Errors
require 'eligible/errors/eligible_error'
require 'eligible/errors/api_connection_error'
require 'eligible/errors/authentication_error'
require 'eligible/errors/api_error'
require 'eligible/errors/invalid_request_error'

# rubocop:disable Metrics/ModuleLength, Style/ClassVars
module Eligible
  @@api_key = nil
  @@test = false
  @@api_version = 1.5
  @@api_base = "https://gds.eligibleapi.com/v#{@@api_version}"
  @@fingerprints = %w(79d62e8a9d59ae687372f8e71345c76d92527fac 4b2c6888ede79d0ee47339dc6fab5a6d0dc3cb0e)

  def self.api_url(url = '')
    @@api_base + url.to_s
  end

  def self.api_key
    @@api_key
  end

  def self.api_key=(api_key)
    @@api_key = api_key
  end

  def self.api_base
    @@api_base
  end

  def self.api_base=(api_base)
    @@api_base = api_base
  end

  def self.test
    @@test ? 'true' : 'false'
  end

  def self.test=(is_test)
    @@test = is_test
  end

  def self.api_version=(version)
    @@api_version = version
  end

  def self.api_version
    @@api_version
  end

  def self.fingerprints
    @@fingerprints
  end

  def self.add_fingerprint(digest)
    $stderr.puts 'The embedded certificate fingerprint was modified. This should only be done if instructed to by eligible support staff'
    @@fingerprints << digest
  end

  def self.direct_response?(params)
    params[:format].is_a?(String) && params[:format].downcase == 'x12'
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def self.request(method, url, api_key, params = {}, headers = {})
    api_key ||= @@api_key
    test = self.test
    api_key = params[:api_key] if params.key?(:api_key)
    test = params[:test] if params.key?(:test)

    fail AuthenticationError, 'No API key provided. (HINT: set your API key using "Eligible.api_key = <API-KEY>".' unless api_key

    lang_version = "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE})"
    debug_info = {
      bindings_version: Eligible::VERSION,
      lang: 'ruby',
      lang_version: lang_version,
      platform: RUBY_PLATFORM,
      publisher: 'eligible',
      uname: uname
    }

    # GET requests, parameters on the query string
    # POST requests, parameters as json in the body
    url = api_url(url)
    case method.to_s.downcase.to_sym
    when :get, :head
      url += "?api_key=#{api_key}"
      if params && params.count > 0
        query_string = Util.flatten_params(params).collect { |key, value| "#{key}=#{Util.url_encode(value)}" }.join('&')
        url += "&#{query_string}"
      end
      url += "&test=#{test}"
      payload = nil
    else
      params.merge!('api_key' => api_key, 'test' => test)
      payload = params.has_key?(:file) ? params : Eligible::JSON.dump(params)
    end

    begin
      headers = { x_eligible_debuginfo: Eligible::JSON.dump(debug_info) }.merge(headers)
    rescue => e
      headers = {
        x_eligible_client_raw_user_agent: debug_info.inspect,
        error: "#{e} (#{e.class})"
      }.merge(headers)
    end

    headers = {
      user_agent: "eligible-ruby/#{Eligible::VERSION}",
      authorization: "Bearer #{api_key}",
      content_type: 'application/x-www-form-urlencoded'
    }.merge(headers)

    headers[:eligible_version] = api_version if api_version

    opts = {
      method: method,
      url: url,
      headers: headers,
      open_timeout: 30,
      payload: payload,
      timeout: 80,
      ssl_verify_callback: verify_certificate
    }

    begin
      response = execute_request(opts)
    rescue SocketError => e
      handle_restclient_error(e)
    rescue NoMethodError => e
      # Work around RestClient bug
      if e.message =~ /\WRequestFailed\W/
        e = APIConnectionError.new('Unexpected HTTP response code')
        handle_restclient_error(e)
      else
        raise
      end
    # rubocop:disable Lint/AssignmentInCondition, Style/AndOr
    rescue RestClient::ExceptionWithResponse => e
      if rcode = e.http_code and rbody = e.http_body
        handle_api_error(rcode, rbody)
      else
        handle_restclient_error(e)
      end
    rescue RestClient::Exception, Errno::ECONNREFUSED => e
      handle_restclient_error(e)
    end

    rbody = response.body
    rcode = response.code
    begin
      # Would use :symbolize_names => true, but apparently there is
      # some library out there that makes symbolize_names not work.
      resp = if direct_response?(params)
               rbody
             else
               Eligible::JSON.load(rbody)
             end
    rescue MultiJson::DecodeError
      raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
    end

    resp = Util.symbolize_names(resp)
    [resp, api_key]
  end

  def self.verify_certificate
    lambda do |preverify_ok, certificate_store|
      return true if test == 'true'
      return false unless preverify_ok
      received = certificate_store.chain.first
      return true unless received.to_der == certificate_store.current_cert.to_der
      valid_fingerprint?(received)
    end
  end

  def self.valid_fingerprint?(received)
    fingerprints.include?(OpenSSL::Digest::SHA1.hexdigest(received.to_der))
  end

  private

  def self.uname
    @@uname ||= RUBY_PLATFORM =~ /linux|darwin/i ? `uname -a 2>/dev/null`.strip : nil
  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.error_message(error)
    result = if error.is_a? Hash
               error[:details] || error[:reject_reason_description] || error
             else
               error
             end
    result.to_s
  end

  # rubocop:disable Style/SignalException
  def self.handle_api_error(rcode, rbody)
    begin
      error_obj = Eligible::JSON.load(rbody)
      error_obj = Util.symbolize_names(error_obj)
      fail EligibleError unless error_obj.key?(:error)
      error = error_obj[:error]
    rescue MultiJson::DecodeError, EligibleError
      raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
    end

    error_msg = error_message(error)

    case rcode
    when 400, 404 then
      raise invalid_request_error(error_msg, rcode, rbody, error_obj)
    when 401
      raise authentication_error(error_msg, rcode, rbody, error_obj)
    else
      raise api_error(error_msg, rcode, rbody, error_obj)
    end
  end

  def self.invalid_request_error(error_msg, rcode, rbody, error_obj)
    InvalidRequestError.new(error_msg, rcode, rbody, error_obj)
  end

  def self.authentication_error(error_msg, rcode, rbody, error_obj)
    AuthenticationError.new(error_msg, rcode, rbody, error_obj)
  end

  def self.api_error(error_msg, rcode, rbody, error_obj)
    APIError.new(error_msg, rcode, rbody, error_obj)
  end

  def self.handle_restclient_error(e)
    case e
    when RestClient::ServerBrokeConnection, RestClient::RequestTimeout
      message = "Could not connect to Eligible (#{@@api_base}).  Please check your internet connection and try again."
    when RestClient::SSLCertificateNotVerified
      message = "Could not verify Eligible's SSL certificate."
    when SocketError
      message = 'Unexpected error communicating when trying to connect to Eligible.'
    else
      message = 'Unexpected error communicating with Eligible. If this problem persists, let us know at support@eligible.com.'
    end
    fail APIConnectionError, "#{message}\n\n(Network error: #{e.message})"
  end
end
