module Eligible
  class Claim < APIResource
    def self.ack(params, api_key = nil)
      send_request(:get, "/claims/#{params[:reference_id]}/acknowledgements.json", api_key, params, :reference_id)
    end

    def self.post(params, api_key = nil)
      send_request(:post, '/claims.json', api_key, params)
    end

    def self.acks(params, api_key = nil)
      send_request(:get, '/claims/acknowledgements.json', api_key, params)
    end

    def self.payment_report(params, api_key = nil)
      require_param(params[:reference_id], 'Reference id')
      url = params.key?(:id) ? "/claims/#{params[:reference_id]}/payment_reports/#{params[:id]}" : "/claims/#{params[:reference_id]}/payment_reports"
      send_request(:get, url, api_key, params)
    end

    def self.payment_reports(params, api_key = nil)
      send_request(:get, '/claims/payment_reports.json', api_key, params)
    end
  end
end
