module Eligible
  class APIResource < EligibleObject
    def self.class_name
      name.split('::').last
    end

    def self.url
      if self == APIResource
        fail NotImplementedError, 'APIResource is an abstract class.  You should perform actions on its subclasses (Plan, Service, etc.)'
      end
      "/#{CGI.escape(class_name.downcase)}/"
    end

    def self.require_param(value, name)
      fail ArgumentError, "#{name} of the claim is required" if value.nil? || (value.is_a?(String) && value.empty?)
    end

    def self.send_request(method, url, api_key, params, required_param_name = nil)
      unless required_param_name.nil?
        required_param = value(params, required_param_name)
        require_param(required_param, required_param_name)
      end
      response, api_key = Eligible.request(method, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.value(params, param_name)
      params[param_name.to_sym] || params[param_name.to_s]
    end
  end
end
