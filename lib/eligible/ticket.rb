module Eligible
  class Ticket < APIResource
    def self.post(params, api_key=nil)
      response, api_key = Eligible.request(:post, '/tickets', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.comments(params, api_key=nil)
      response, api_key = Eligible.request(:post, "/tickets/#{params[:reference_id]}/comments", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.all
      response, api_key = Eligible.request(:get, '/tickets', api_key)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.get(params, api_key=nil)
      response, api_key = Eligible.request(:get, "/tickets/#{params[:reference_id]}", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.delete(params, api_key=nil)
      response, api_key = Eligible.request(:delete, "/tickets/#{params[:reference_id]}", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
    def self.update(params, api_key=nil)
      response, api_key = Eligible.request(:put, "/tickets/#{params[:reference_id]}", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

  end
end

