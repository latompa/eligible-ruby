module Eligible
  class Medicare < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, '/medicare/coverage.json', api_key, params)
    end

    def self.batch_post(params, api_key = nil)
      send_request(:post, '/medicare/coverage/batch.json', api_key, params)
    end
  end
end
