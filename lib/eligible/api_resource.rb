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
      value = value.to_s if value.is_a?(Numeric)
      fail ArgumentError, "#{name} of the claim is required" if value.nil? || value.empty?
    end

    def self.send_request(method, url, api_key, params, required_value = nil, required_param = nil)
      require_param(required_value, required_param) unless required_param.nil?
      response, api_key = Eligible.request(method, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
