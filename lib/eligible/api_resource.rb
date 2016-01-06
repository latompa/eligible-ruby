module Eligible
  class APIResource < EligibleObject
    def self.class_name
      name.split('::')[-1]
    end

    def self.url
      if self == APIResource
        fail NotImplementedError, 'APIResource is an abstract class.  You should perform actions on its subclasses (Plan, Service, etc.)'
      end
      "/#{CGI.escape(class_name.downcase)}/"
    end
  end
end
