module Eligible

  class Enrollment < APIResource

    def self.get(params, api_key=nil)
      response, api_key = Eligible.request(:get, "/enrollment.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.post(params, api_key=nil)
      response, api_key = Eligible.request(:post, "/enrollment.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def all
      error ? nil : to_hash
    end

    def enrollment_npis
      r = Array.new
      values[0].each do |value|
        r << value[:enrollment_npi]
      end
      r
    end
  end

end