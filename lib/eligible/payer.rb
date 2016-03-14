module Eligible
  class Payer < APIResource
    def self.payer_url(params = nil)
      if params.nil?
        '/payers.json'
      else
        payer_id = value(params, :payer_id)
        "/payers/#{payer_id}.json"
      end
    end

    def self.list(params, api_key = nil)
      send_request(:get, payer_url, api_key, params)
    end

    def self.get(params, api_key = nil)
      send_request(:get, payer_url(params), api_key, params, :payer_id)
    end

    def self.search_options(params, api_key = nil)
      payer_id = value(params, :payer_id)
      url = payer_id.nil? ? '/payers/search_options' : "/payers/#{payer_id}/search_options"
      send_request(:get, url, api_key, params)
    end
  end
end
