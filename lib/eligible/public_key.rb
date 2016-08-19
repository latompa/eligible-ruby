require 'openssl'

module Eligible
  class PublicKey < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, api_url('public_keys', params, :key_id), api_key, params, :key_id)
    end

    def self.post(params, api_key = nil)
      send_request(:post, api_url('public_keys'), api_key, params)
    end

    def self.activate(params, api_key = nil)
      key_id = Util.value(params, :key_id)
      send_request(:get, "/public_keys/#{key_id}/activate.json", api_key, params, :key_id)
    end

    def self.all(params, api_key = nil)
      send_request(:get, api_url('public_keys'), api_key, params)
    end

    def self.create_pair
      rsa_key = OpenSSL::PKey::RSA.new(4096)
      [ rsa_key.to_pem, rsa_key.public_key.to_pem ]
    end
  end
end
