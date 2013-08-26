module Eligible
  class Claim < APIResource

    class << self

      def get(params, api_key = nil)
        response, api_key = Eligible.request(:get, "/claims/acknowledgements/#{params[:reference_id]}.json", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

      def post(params, api_key = nil)
        response, api_key = Eligible.request(:post, '/claims.json', api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

      def all(api_key = nil)
        response, api_key = Eligible.request(:get, '/claims/acknowledgements.json', api_key)
        Util.convert_to_eligible_object(response, api_key)
      end

    end

    def status
      error ? nil : to_hash
    end

  end
end