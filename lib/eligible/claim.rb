module Eligible
  class Claim < APIResource
    def self.ack(params, api_key = nil)
      reference_id = Util.value(params, :reference_id)
      send_request(:get, "/claims/#{reference_id}/acknowledgements.json", api_key, params, :reference_id)
    end

    def self.post(params, api_key = nil)
      send_request(:post, '/claims.json', api_key, params)
    end

    def self.acks(params, api_key = nil)
      send_request(:get, '/claims/acknowledgements.json', api_key, params)
    end

    def self.payment_report(params, api_key = nil)
      reference_id = Util.value(params, :reference_id)
      require_param(reference_id, 'Reference id')
      id = Util.value(params, :id)
      url = id.nil? ? "/claims/#{reference_id}/payment_reports" : "/claims/#{reference_id}/payment_reports/#{id}"
      send_request(:get, url, api_key, params)
    end

    def self.payment_reports(params, api_key = nil)
      send_request(:get, '/claims/payment_reports.json', api_key, params)
    end
  end
end
