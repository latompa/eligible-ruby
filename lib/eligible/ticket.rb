module Eligible
  class Ticket < APIResource
    def self.ticket_url(params = nil, comments = false)
      if params.nil?
        '/tickets'
      else
        id = Util.value(params, :id)
        if comments
          "/tickets/#{id}/comments"
        else
          "/tickets/#{id}"
        end
      end
    end

    def self.create(params, api_key = nil)
      send_request(:post, ticket_url, api_key, params)
    end

    def self.comments(params, api_key = nil)
      send_request(:post, ticket_url(params, true), api_key, params, :id)
    end

    def self.all(params, api_key = nil)
      send_request(:get, ticket_url, api_key, params)
    end

    def self.get(params, api_key = nil)
      send_request(:get, ticket_url(params), api_key, params, :id)
    end

    def self.delete(params, api_key = nil)
      send_request(:delete, ticket_url(params), api_key, params, :id)
    end

    def self.update(params, api_key = nil)
      send_request(:put, ticket_url(params), api_key, params, :id)
    end
  end
end
