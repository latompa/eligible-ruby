module Eligible
  class Payment < APIResource
    def self.get(params, api_key = nil)
      response, api_key = Eligible.request(:get, '/payment/status.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
