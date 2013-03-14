module Eligible
  class APIResource < EligibleObject
    def self.class_name
      self.name.split('::')[-1]
    end

    def self.url()
      if self == APIResource
        raise NotImplementedError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Plan, Service, etc.)')
      end
      "/#{CGI.escape(class_name.downcase)}/all.json"
    end
  end
end