module Eligible
  class Medicare < CoverageResource
    def self.get_uri
      return '/medicare/coverage.json'
    end

    def self.post_uri
      return '/medicare/coverage/batch.json'
    end
  end
end
