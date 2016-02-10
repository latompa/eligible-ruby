module Eligible
  class OriginalSignaturePdf < APIResource
    def self.get(params, api_key = nil)
      send_request(:get, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf", api_key, params, params[:enrollment_npi_id], 'Enrollment Npi id')
    end

    def self.post(params, api_key = nil)
      send_request(:post, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf", api_key, params, params[:enrollment_npi_id], 'Enrollment Npi id')
    end

    def self.update(params, api_key = nil)
      send_request(:put, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf", api_key, params, params[:enrollment_npi_id], 'Enrollment Npi id')
    end

    def self.delete(params, api_key = nil)
      send_request(:delete, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf", api_key, params, params[:enrollment_npi_id], 'Enrollment Npi id')
    end

    def self.download(params, api_key = nil)
      require_param(params[:enrollment_npi_id], 'Enrollment Npi id')
      params[:format] = "x12"
      response, api_key = Eligible.request(:get, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf/download", api_key, params)
      filename = "/tmp/original_signature_pdf.pdf"
      file = File.new(filename, "w")
      file.write response
      file.close
    end
  end
end
