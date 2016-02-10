module Eligible
  class Payment < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, '/payment/status.json', api_key, params)
    end
  end
end
