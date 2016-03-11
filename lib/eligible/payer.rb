module Eligible
  class Payer < APIResource
    def self.list(params, api_key = nil)
      send_request(:get, '/payers.json', api_key, params)
    end

    def self.get(params, api_key = nil)
      payer_id = value(params, :payer_id)
      send_request(:get, "/payers/#{payer_id}.json", api_key, params, :payer_id)
    end

    def self.search_options(params, api_key = nil)
      payer_id = value(params, :payer_id)
      url = payer_id.nil? ? '/payers/search_options' : "/payers/#{payer_id}/search_options"
      send_request(:get, url, api_key, params)
    end
  end
end
