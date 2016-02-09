module Eligible
  class Customer < APIResource
    def self.get(params, api_key = nil)
      self.check_param(params[:customer_id], 'Customer id')
      response, api_key = Eligible.request(:get, "/customers/#{params[:customer_id]}.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.post(params, api_key = nil)
      response, api_key = Eligible.request(:post, '/customers.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.update(params, api_key = nil)
      self.check_param(params[:customer_id], 'Customer id')
      response, api_key = Eligible.request(:put, "/customers/#{params[:customer_id]}.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.all(params, api_key = nil)
      response, api_key = Eligible.request(:get, "/customers.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
