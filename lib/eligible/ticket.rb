module Eligible
  class Ticket < APIResource
    def self.create(params, api_key = nil)
      send_request(:post, '/tickets', api_key, params)
    end

    def self.comments(params, api_key = nil)
      send_request(:post, "/tickets/#{params[:id]}/comments", api_key, params, params[:id], 'Id')
    end

    def self.all(params, api_key = nil)
      send_request(:get, '/tickets', api_key, params)
    end

    def self.get(params, api_key = nil)
      send_request(:get, "/tickets/#{params[:id]}", api_key, params, params[:id], 'Id')
    end

    def self.delete(params, api_key = nil)
      send_request(:delete, "/tickets/#{params[:id]}", api_key, params, params[:id], 'Id')
    end

    def self.update(params, api_key = nil)
      send_request(:put, "/tickets/#{params[:id]}", api_key, params, params[:id], 'Id')
    end
  end
end
