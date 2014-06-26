module Eligible
  class Enrollment < APIResource

    class << self

      def get(params, api_key=nil)
        response, api_key = Eligible.request(:get, "/enrollment_npis/#{params[:enrollment_npi_id]}.json", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

      def post(params, api_key=nil)
        response, api_key = Eligible.request(:post, "/enrollment_npis.json", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end
      
      def update(params, api_key=nil)
        response, api_key = Eligible.request(:put, "/enrollment_npis/#{params[:enrollment_npi_id]}.json", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end 

    end

    def enrollment_npis
      values.first[:enrollment_npis]
    end

  end
end