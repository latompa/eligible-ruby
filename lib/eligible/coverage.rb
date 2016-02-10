module Eligible
  class Coverage < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, '/coverage/all.json', api_key, params)
    end

    def self.cost_estimate(params, api_key = nil)
      send_request(:get, '/coverage/cost_estimates.json', api_key, params)
    end

    def self.batch_post(params, api_key = nil)
      send_request(:post, '/coverage/all/batch.json', api_key, params)
    end

    def self.batch_medicare_post(params, api_key = nil)
      send_request(:post, '/medicare/coverage/batch.json', api_key, params)
    end
  end
end
