module Eligible
  class Enrollment < APIResource
    def self.enrollment_url(params = nil)
      if params.nil?
        "/enrollment_npis.json"
      else
        enrollment_npi_id = value(params, :enrollment_npi_id)
        "/enrollment_npis/#{enrollment_npi_id}.json"
      end
    end

    def self.get(params, api_key = nil)
      send_request(:get, enrollment_url(params), api_key, params, :enrollment_npi_id)
    end

    def self.list(params, api_key = nil)
      send_request(:get, enrollment_url, api_key, params)
    end

    def self.post(params, api_key = nil)
      send_request(:post, enrollment_url, api_key, params)
    end

    def self.update(params, api_key = nil)
      send_request(:put, enrollment_url(params), api_key, params, :enrollment_npi_id)
    end

    def enrollment_npis
      values.first[:enrollment_npis]
    end
  end
end
