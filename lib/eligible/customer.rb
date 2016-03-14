module Eligible
  class Customer < APIResource
    def self.customer_url(params = nil)
      if params.nil?
        "/customers.json"
      else
        customer_id = value(params, :customer_id)
        "/customers/#{customer_id}.json"
      end
    end

    def self.get(params, api_key = nil)
      send_request(:get, customer_url(params), api_key, params, :customer_id)
    end

    def self.post(params, api_key = nil)
      send_request(:post, customer_url, api_key, params)
    end

    def self.update(params, api_key = nil)
      send_request(:put, customer_url(params), api_key, params, :customer_id)
    end

    def self.all(params, api_key = nil)
      send_request(:get, customer_url, api_key, params)
    end
  end
end
