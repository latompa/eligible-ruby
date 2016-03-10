module Eligible
  class PreauthResource < APIResource
    def self.inquiry(params, api_key = nil)
      send_request(:get, inquiry_uri, api_key, params)
    end

    def self.create(params, api_key = nil)
      send_request(:post, create_uri, api_key, params)
    end

    def self.inquiry_uri
      fail NotImplementedError, "Please implement class method #{self}.inquiry_uri"
    end

    def self.create_uri
      fail NotImplementedError, "Please implement class method #{self}.create_uri"
    end
  end
end
