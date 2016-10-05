module Eligible
  class Precert < PreauthResource
    def self.require(params, api_key = nil)
      send_request(:get, '/precert/require.json', api_key, params)
    end

    def self.get_uri
      return '/precert/inquiry.json'
    end

    def self.post_uri
      return '/precert/create.json'
    end
  end
end
