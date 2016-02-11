module Eligible
  class Coverage < CoverageResource
    def self.get(params, api_key = nil)
      @url = '/coverage/all.json'
      super(params, api_key)
    end

    def self.cost_estimate(params, api_key = nil)
      send_request(:get, '/coverage/cost_estimates.json', api_key, params)
    end

    def self.batch_post(params, api_key = nil)
      @url = '/coverage/all/batch.json'
      super(params, api_key)
    end

    def self.batch_medicare_post(params, api_key = nil)
      send_request(:post, '/medicare/coverage/batch.json', api_key, params)
    end
  end
end
