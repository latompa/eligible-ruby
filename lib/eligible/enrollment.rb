module Eligible

  class Enrollment < APIResource

    def self.get(params, api_key=nil)
      response, api_key = Eligible.request(:get, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.post(params, api_key=nil)
      response, api_key = Eligible.request(:post, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def all
      error ? nil : to_hash
    end
  end

end