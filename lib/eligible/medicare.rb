module Eligible
  class Medicare < APIResource
    def self.get(params, api_key = nil)
      response, api_key = Eligible.request(:get, '/medicare/coverage.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.batch_post(params, api_key = nil)
      response, api_key = Eligible.request(:post, '/medicare/coverage/batch.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
