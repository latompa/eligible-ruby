module Eligible
  class Enrollment < APIResource

    class << self

      def get(params, api_key=nil)
        response, api_key = Eligible.request(:get, "/enrollment.json", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

      def post(params, api_key=nil)
        response, api_key = Eligible.request(:post, "/enrollment.json", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

    end

    def all
      error ? nil : to_hash
    end

    def enrollment_npis
      values[0].collect {|v| v[:enrollment_npi]}
    end

  end
end