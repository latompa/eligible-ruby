module Eligible
  class Coverage < CoverageResource
    def self.get_uri
      return '/coverage/all.json'
    end

    def self.post_uri
      return '/coverage/all/batch.json'
    end

    def self.cost_estimate(params, api_key = nil)
      send_request(:get, '/coverage/cost_estimates.json', api_key, params)
    end

    def self.batch_medicare_post(params, api_key = nil)
      send_request(:post, '/medicare/coverage/batch.json', api_key, params)
    end
  end
end
