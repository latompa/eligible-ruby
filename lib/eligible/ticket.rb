module Eligible
  class Ticket < APIResource
    def self.create(params, api_key = nil)
      send_request(:post, '/tickets', api_key, params)
    end

    def self.comments(params, api_key = nil)
      id = value(params, :id)
      send_request(:post, "/tickets/#{id}/comments", api_key, params, :id)
    end

    def self.all(params, api_key = nil)
      send_request(:get, '/tickets', api_key, params)
    end

    def self.get(params, api_key = nil)
      id = value(params, :id)
      send_request(:get, "/tickets/#{id}", api_key, params, :id)
    end

    def self.delete(params, api_key = nil)
      id = value(params, :id)
      send_request(:delete, "/tickets/#{id}", api_key, params, :id)
    end

    def self.update(params, api_key = nil)
      id = value(params, :id)
      send_request(:put, "/tickets/#{id}", api_key, params, :id)
    end
  end
end
