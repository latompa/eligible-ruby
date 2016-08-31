require 'openssl'
require 'base64'

module Eligible
  class Lockbox < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, api_url('lockboxes', params, :lockbox_id), api_key, params, :lockbox_id)
    end

    def self.all(params, api_key = nil)
      send_request(:get, api_url('lockboxes'), api_key, params)
    end

    def self.extract_private_key(params)
      private_key = Util.value(params, :private_key)
      fail ArgumentError, "Private key is required for decryption" if private_key.nil?
      private_key
    end

    def self.delete_private_key!(params)
      params.delete('private_key')
      params.delete(:private_key)
    end

    def self.decrypt_data(data, encrypted_data_key, private_key)
      pkey = OpenSSL::PKey::RSA.new(private_key)
      aes_key = pkey.private_decrypt(Base64.decode64(encrypted_data_key))
      sha_key = Digest::SHA256.hexdigest(aes_key)
      Encryptor.decrypt(value: Base64.decode64(data), key: sha_key, insecure_mode: true)
    end

    def self.get_and_decrypt_from_lockbox(params, api_key = nil)
      private_key = extract_private_key(params)
      delete_private_key!(params)
      req = get(params, api_key).to_hash
      decrypt_data(req[:encrypted_data], req[:encrypted_key], private_key)
    end
  end
end
