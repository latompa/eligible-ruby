module Eligible
  class Demographic < CoverageResource
    def self.get_uri
      return '/demographic/all.json'
    end

    def self.post_uri
      return '/demographic/all/batch.json'
    end
  end
end
