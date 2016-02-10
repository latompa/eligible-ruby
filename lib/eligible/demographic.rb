module Eligible
  class Demographic < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, '/demographic/all.json', api_key, params)
    end

    def self.batch_post(params, api_key = nil)
      send_request(:post, '/demographic/all/batch.json', api_key, params)
    end
  end
end
