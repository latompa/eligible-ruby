module Eligible
  class Customer < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, "/customers/#{params[:customer_id]}.json", api_key, params, params[:customer_id], 'Customer id')
    end

    def self.post(params, api_key = nil)
      send_request(:post, '/customers.json', api_key, params)
    end

    def self.update(params, api_key = nil)
      send_request(:put, "/customers/#{params[:customer_id]}.json", api_key, params, params[:customer_id], 'Customer id')
    end

    def self.all(params, api_key = nil)
      send_request(:get, "/customers.json", api_key, params)
    end
  end
end
