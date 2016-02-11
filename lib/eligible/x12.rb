module Eligible
  class X12 < APIResource
    def self.post(params, api_key = nil)
      params[:format] = 'x12'
      send_request(:post, '/x12', api_key, params)
    end
  end
end
