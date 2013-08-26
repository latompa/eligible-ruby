module Eligible
  class Ticket < APIResource

    class << self

      def create(params, api_key=nil)
        response, api_key = Eligible.request(:post, '/tickets', api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

      def comments(params, api_key=nil)
        response, api_key = Eligible.request(:post, "/tickets/#{params[:reference_id]}/comments", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

      def all
        response, api_key = Eligible.request(:get, '/tickets', api_key)
        Util.convert_to_eligible_object(response, api_key)
      end

      def get(params, api_key=nil)
        response, api_key = Eligible.request(:get, "/tickets/#{params[:reference_id]}", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end

      def delete(params, api_key=nil)
        response, api_key = Eligible.request(:delete, "/tickets/#{params[:reference_id]}", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end
      
      def update(params, api_key=nil)
        response, api_key = Eligible.request(:put, "/tickets/#{params[:reference_id]}", api_key, params)
        Util.convert_to_eligible_object(response, api_key)
      end 

    end

  end
end

