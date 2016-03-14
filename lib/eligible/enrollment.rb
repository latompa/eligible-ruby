module Eligible
  class Enrollment < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, api_url('enrollment_npis', params, :enrollment_npi_id), api_key, params, :enrollment_npi_id)
    end

    def self.list(params, api_key = nil)
      send_request(:get, api_url('enrollment_npis'), api_key, params)
    end

    def self.post(params, api_key = nil)
      send_request(:post, api_url('enrollment_npis'), api_key, params)
    end

    def self.update(params, api_key = nil)
      send_request(:put, api_url('enrollment_npis', params, :enrollment_npi_id), api_key, params, :enrollment_npi_id)
    end

    def enrollment_npis
      values.first[:enrollment_npis]
    end
  end
end
