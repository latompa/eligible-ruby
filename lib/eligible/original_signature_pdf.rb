module Eligible
  class OriginalSignaturePdf < APIResource
    def self.get(params, api_key = nil)
      enrollment_npi_id = value(params, :enrollment_npi_id)
      send_request(:get, "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf", api_key, params, :enrollment_npi_id)
    end

    def self.post(params, api_key = nil)
      enrollment_npi_id = value(params, :enrollment_npi_id)
      send_request(:post, "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf", api_key, params, :enrollment_npi_id)
    end

    def self.update(params, api_key = nil)
      enrollment_npi_id = value(params, :enrollment_npi_id)
      send_request(:put, "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf", api_key, params, :enrollment_npi_id)
    end

    def self.delete(params, api_key = nil)
      enrollment_npi_id = value(params, :enrollment_npi_id)
      send_request(:delete, "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf", api_key, params, :enrollment_npi_id)
    end

    def self.download(params, api_key = nil)
      enrollment_npi_id = value(params, :enrollment_npi_id)
      require_param(enrollment_npi_id, 'Enrollment Npi id')
      params[:format] = 'x12'
      response = Eligible.request(:get, "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf/download", api_key, params)[0]
      filename = params[:filename] || '/tmp/original_signature_pdf.pdf'
      file = File.new(filename, 'w')
      file.write response
      file.close
    end
  end
end
