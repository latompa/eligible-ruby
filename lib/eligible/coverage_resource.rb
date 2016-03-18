module Eligible
  class CoverageResource < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, get_uri, api_key, params)
    end

    def self.post(params, api_key = nil)
      send_request(:post, post_uri, api_key, params)
    end

    def self.get_uri
      fail NotImplementedError, "Please implement class method #{self}.get_uri"
    end

    def self.post_uri
      fail NotImplementedError, "Please implement class method #{self}.post_uri"
    end

    class << self
      alias_method :batch_post, :post
    end
  end
end
