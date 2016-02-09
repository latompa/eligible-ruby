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

    def self.check_param(param, name)
      param = param.to_s if param.is_a?(Numeric)
      fail ArgumentError, "#{name} of the claim is required" if param.nil? || param.empty?
    end
  end
end
