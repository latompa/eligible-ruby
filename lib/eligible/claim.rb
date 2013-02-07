module Eligible
  class Claim < APIResource
    def self.get(params, api_key=nil)
      response, api_key = Eligible.request(:get, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def status
      error ? nil : to_hash
    end
  end
end