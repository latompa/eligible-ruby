module Eligible
  class Payer < APIResource
    def self.list(params, api_key = nil)
      response, api_key = Eligible.request(:get, "/payers.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.get(params, api_key = nil)
      self.check_param(params[:payer_id], 'Payer id')
      response, api_key = Eligible.request(:get, "/payers/#{params[:payer_id]}.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.search_options(params, api_key = nil)
      url = params.has_key?(:payer_id) ? "/payers/#{params[:payer_id]}/search_options" : "/payers/search_options"
      response, api_key = Eligible.request(:get, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
