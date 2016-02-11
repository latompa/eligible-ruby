module Eligible
  class Demographic < CoverageResource
    def self.get(params, api_key = nil)
      @url = '/demographic/all.json'
      super(params, api_key)
    end

    def self.batch_post(params, api_key = nil)
      @url = '/demographic/all/batch.json'
      super(params, api_key)
    end
  end
end
