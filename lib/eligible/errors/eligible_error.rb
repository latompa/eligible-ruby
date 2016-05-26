module Eligible
  class EligibleError < StandardError
    attr_reader :message
    attr_reader :http_status
    attr_reader :http_body
    attr_reader :json_body
    attr_reader :errors

    def initialize(message = nil, http_status = nil, http_body = nil, json_body = nil, errors = [])
      @message = message
      @http_status = http_status
      @http_body = http_body
      @json_body = json_body
      @errors = errors
      if @errors && @errors.size > 0
        @message = "Multiple errors"
      end
    end

    def to_s
      status_string = @http_status.nil? ? '' : "(Status #{@http_status}) "
      "#{status_string}#{@message}"
    end
  end
end
