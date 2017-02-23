module Eligible
  class SessionToken < APIResource
    def self.create(params, api_key = nil)
      send_request(:post, '/session_tokens/create.json', api_key, params)
    end
  end
end
