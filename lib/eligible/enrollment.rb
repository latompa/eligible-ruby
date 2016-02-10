module Eligible
  class Enrollment < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, "/enrollment_npis/#{params[:enrollment_npi_id]}.json", api_key, params, :enrollment_npi_id)
    end

    def self.list(params, api_key = nil)
      send_request(:get, "/enrollment_npis.json", api_key, params)
    end

    def self.post(params, api_key = nil)
      send_request(:post, '/enrollment_npis.json', api_key, params)
    end

    def self.update(params, api_key = nil)
      send_request(:put, "/enrollment_npis/#{params[:enrollment_npi_id]}.json", api_key, params, :enrollment_npi_id)
    end

    def enrollment_npis
      values.first[:enrollment_npis]
    end
  end
end
