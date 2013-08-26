module Eligible
  module JSON
    def self.dump(*args)
      MultiJson.dump(*args)
    end

    def self.load(*args)
      MultiJson.load(*args)
    end
  end
end
