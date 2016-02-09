module Eligible
  class Enrollment < APIResource
    def self.get(params, api_key = nil)
      self.check_param(params[:enrollment_npi_id], 'Enrollment Npi id')
      response, api_key = Eligible.request(:get, "/enrollment_npis/#{params[:enrollment_npi_id]}.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.list(params, api_key = nil)
      response, api_key = Eligible.request(:get, "/enrollment_npis.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.post(params, api_key = nil)
      response, api_key = Eligible.request(:post, '/enrollment_npis.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.update(params, api_key = nil)
      self.check_param(params[:enrollment_npi_id], 'Enrollment Npi id')
      response, api_key = Eligible.request(:put, "/enrollment_npis/#{params[:enrollment_npi_id]}.json", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def enrollment_npis
      values.first[:enrollment_npis]
    end
  end
end
