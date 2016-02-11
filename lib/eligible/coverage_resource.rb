module Eligible
  class CoverageResource < APIResource
    def self.get(params, api_key)
      send_request(:get, @url, api_key, params)
    end

    def self.batch_post(params, api_key)
      send_request(:post, @url, api_key, params)
    end
  end
end
