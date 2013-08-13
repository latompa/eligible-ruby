require 'cgi'
require 'set'
require 'rubygems'
require 'openssl'
require 'json' 

gem 'rest-client', '~> 1.4'
require 'rest_client'
require 'multi_json'

require 'eligible/version'
require 'eligible/util'
require 'eligible/json'
require 'eligible/eligible_object'
require 'eligible/api_resource'
require 'eligible/plan'
require 'eligible/service'
require 'eligible/demographic'
require 'eligible/claim'
require 'eligible/enrollment'
require 'eligible/coverage'
require 'eligible/payment'
require 'eligible/x12'

# Errors
require 'eligible/errors/eligible_error'
require 'eligible/errors/api_connection_error'
require 'eligible/errors/authentication_error'
require 'eligible/errors/api_error'
require 'eligible/errors/invalid_request_error'

module Eligible
  @@api_key  = nil
  @@test = false
  @@api_base = 'https://gds.eligibleapi.com/v1.1'
  @@api_version = 1.1

  def self.api_url(url='')
    @@api_base + url
  end

  def self.api_key
    @@api_key
  end

  def self.api_key=(api_key)
    @@api_key = api_key
  end


  def self.test
    @@test? 'true':'false'
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

  def self.request(method, url, api_key, params={}, headers={})
    api_key ||= @@api_key
    raise AuthenticationError.new('No API key provided. (HINT: set your API key using "Eligible.api_key = <API-KEY>".') unless api_key

    # if !verify_ssl_certs
    #   unless @no_verify
    #     $stderr.puts "WARNING: Running without SSL cert verification.  Execute 'Eligible.verify_ssl_certs = true' to enable verification."
    #     @no_verify = true
    #   end
    #   ssl_opts = { :verify_ssl => false }
    # elsif !Util.file_readable(@@ssl_bundle_path)
    #   unless @no_bundle
    #     $stderr.puts "WARNING: Running without SSL cert verification because #{@@ssl_bundle_path} isn't readable"
    #     @no_bundle = true
    #   end
    #   ssl_opts = { :verify_ssl => false }
    # else
    #   ssl_opts = {
    #     :verify_ssl => OpenSSL::SSL::VERIFY_PEER,
    #     :ssl_ca_file => @@ssl_bundle_path
    #   }
    # end
    uname = (@@uname ||= RUBY_PLATFORM =~ /linux|darwin/i ? `uname -a 2>/dev/null`.strip : nil)
    lang_version = "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE})"
    ua = {
      :bindings_version => Eligible::VERSION,
      :lang => 'ruby',
      :lang_version => lang_version,
      :platform => RUBY_PLATFORM,
      :publisher => 'eligible',
      :uname => uname
    }

    # params = Util.objects_to_ids(params)
    url = self.api_url(url)
    case method.to_s.downcase.to_sym
    when :get, :head, :delete
      # Make params into GET parameters
      url += "?api_key=#{api_key}"
      if params && params.count > 0
        query_string = Util.flatten_params(params).collect{|key, value| "#{key}=#{Util.url_encode(value)}"}.join('&')
        url += "&#{query_string}"
      end
      url +="&test=#{self.test}"
      payload = nil
    else
      payload = params.merge!({'api_key' => api_key ,'test' => self.test }).to_json #Util.flatten_params(params).collect{|(key, value)| "#{key}=#{Util.url_encode(value)}"}.join('&')
    end

    begin
      headers = { :x_eligible_client_user_agent => Eligible::JSON.dump(ua) }.merge(headers)
    rescue => e
      headers = {
        :x_eligible_client_raw_user_agent => ua.inspect,
        :error => "#{e} (#{e.class})"
      }.merge(headers)
    end

    headers = {
      :user_agent => "Eligible/v1 RubyBindings/#{Eligible::VERSION}",
      :authorization => "Bearer #{api_key}",
      :content_type => 'application/x-www-form-urlencoded'
    }.merge(headers)

    if self.api_version
      headers[:eligible_version] = self.api_version
    end

    opts = {
      :method => method,
      :url => url,
      :headers => headers,
      :open_timeout => 30,
      :payload => payload,
      :timeout => 80
    }#.merge(ssl_opts)
    
    begin
      response = execute_request(opts)

    rescue SocketError => e
      self.handle_restclient_error(e)
    rescue NoMethodError => e
      # Work around RestClient bug
      if e.message =~ /\WRequestFailed\W/
        e = APIConnectionError.new('Unexpected HTTP response code')
        self.handle_restclient_error(e)
      else
        raise
      end
    rescue RestClient::ExceptionWithResponse => e
      if rcode = e.http_code and rbody = e.http_body
        self.handle_api_error(rcode, rbody)
      else
        self.handle_restclient_error(e)
      end
    rescue RestClient::Exception, Errno::ECONNREFUSED => e
      self.handle_restclient_error(e)
    end

    rbody = response.body
    rcode = response.code
    begin
      # Would use :symbolize_names => true, but apparently there is
      # some library out there that makes symbolize_names not work.
      resp = params[:format] && params[:format].match(/x12/i) ? rbody : Eligible::JSON.load(rbody) 
    rescue MultiJson::DecodeError
      raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
    end

    resp = Util.symbolize_names(resp)
    [resp, api_key]
  end

  private

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.handle_api_error(rcode, rbody)
    begin
      error_obj = Eligible::JSON.load(rbody)
      error_obj = Util.symbolize_names(error_obj)
      error = error_obj[:error] or raise EligibleError.new # escape from parsing
    rescue MultiJson::DecodeError, EligibleError
      raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
    end

    case rcode
    when 400, 404 then
      raise invalid_request_error(error, rcode, rbody, error_obj)
    when 401
      raise authentication_error(error, rcode, rbody, error_obj)
    else
      raise api_error(error, rcode, rbody, error_obj)
    end
  end

  def self.invalid_request_error(error, rcode, rbody, error_obj)
    InvalidRequestError.new(error, rcode, rbody, error_obj)
  end

  def self.authentication_error(error, rcode, rbody, error_obj)
    AuthenticationError.new(error[0][:message], rcode, rbody, error_obj)
  end

  def self.api_error(error, rcode, rbody, error_obj)
    APIError.new(error[0][:message], rcode, rbody, error_obj)
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
    message += "\n\n(Network error: #{e.message})"
    raise APIConnectionError.new(message)
  end

end
