module Eligible
  class Customer < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, api_url('customers', params, :customer_id), api_key, params, :customer_id)
    end

    def self.post(params, api_key = nil)
      send_request(:post, api_url('customers'), api_key, params)
    end

    def self.update(params, api_key = nil)
      send_request(:put, api_url('customers', params, :customer_id), api_key, params, :customer_id)
    end

    def self.all(params, api_key = nil)
      send_request(:get, api_url('customers'), api_key, params)
    end
  end
end
