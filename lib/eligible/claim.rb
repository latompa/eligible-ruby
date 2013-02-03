module Eligible
  class Claim < APIResource
    def self.all(params, api_key=nil)
      response, api_key = Eligible.request(:get, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
      # refresh_from(response, api_key)
      # self
      # response
    end
  end
end