module Eligible
  class Demographic < APIResource
    class << self

      def get(params, api_key=nil)
        response, api_key = Eligible.request(:get, '/demographic/all.json', api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

      def batch_post(params, api_key=nil)
        response, api_key = Eligible.request(:post, '/demographic/all/batch.json', api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end
    end
  end
end
