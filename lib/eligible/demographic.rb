module Eligible
  class Demographic < APIResource
    def self.get(params, api_key = nil)
      response, api_key = Eligible.request(:get, '/demographic/all.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.batch_post(params, api_key = nil)
      response, api_key = Eligible.request(:post, '/demographic/all/batch.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
