module Eligible
  class X12 < APIResource
    def self.post(params, api_key = nil)
      response, api_key = Eligible.request(:post, '/x12', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
