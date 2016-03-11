module Eligible
  class Customer < APIResource
    def self.get(params, api_key = nil)
      customer_id = value(params, :customer_id)
      send_request(:get, "/customers/#{customer_id}.json", api_key, params, :customer_id)
    end

    def self.post(params, api_key = nil)
      send_request(:post, '/customers.json', api_key, params)
    end

    def self.update(params, api_key = nil)
      customer_id = value(params, :customer_id)
      send_request(:put, "/customers/#{customer_id}.json", api_key, params, :customer_id)
    end

    def self.all(params, api_key = nil)
      send_request(:get, '/customers.json', api_key, params)
    end
  end
end
