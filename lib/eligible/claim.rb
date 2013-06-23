module Eligible
  class Claim < APIResource
    def self.get(params, api_key=nil)
      response, api_key = Eligible.request(:get, "/claims/acknowledgements/#{params[:reference_id]}.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.post(params, api_key=nil)
      response, api_key = Eligible.request(:post, "/claims.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.all(api_key=nil)
      response, api_key = Eligible.request(:get, "/claims/acknowledgements.json", api_key)
      Util.convert_to_eligible_object(response, api_key)
    end

    def status
      error ? nil : to_hash
    end
  end
end