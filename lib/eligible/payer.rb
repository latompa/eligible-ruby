module Eligible
  class Payer < APIResource
    def self.list(params, api_key = nil)
      send_request(:get, '/payers.json', api_key, params)
    end

    def self.get(params, api_key = nil)
      send_request(:get, "/payers/#{params[:payer_id]}.json", api_key, params, :payer_id)
    end

    def self.search_options(params, api_key = nil)
      url = params.key?(:payer_id) ? "/payers/#{params[:payer_id]}/search_options" : '/payers/search_options'
      send_request(:get, url, api_key, params)
    end
  end
end
