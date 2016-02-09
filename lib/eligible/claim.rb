module Eligible
  class Claim < APIResource
    def self.ack(params, api_key = nil)
      self.check_param(params[:reference_id], 'Reference id')
      response, api_key = Eligible.request(:get, "/claims/#{params[:reference_id]}/acknowledgements.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.post(params, api_key = nil)
      response, api_key = Eligible.request(:post, '/claims.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.acks(params, api_key = nil)
      response, api_key = Eligible.request(:get, '/claims/acknowledgements.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.payment_report(params, api_key = nil)
      self.check_param(params[:reference_id], 'Reference id')
      url = params.has_key?(:id) ? "/claims/#{params[:reference_id]}/payment_reports/#{params[:id]}" : "/claims/#{params[:reference_id]}/payment_reports"
      response, api_key = Eligible.request(:get, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.payment_reports(params, api_key = nil)
      response, api_key = Eligible.request(:get, '/claims/payment_reports.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end
  end
end
