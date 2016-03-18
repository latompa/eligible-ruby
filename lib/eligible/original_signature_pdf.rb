module Eligible
  class OriginalSignaturePdf < APIResource
    def self.original_signature_pdf_url(params)
      enrollment_npi_id = Util.value(params, :enrollment_npi_id)
      "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf"
    end

    def self.get(params, api_key = nil)
      send_request(:get, original_signature_pdf_url(params), api_key, params, :enrollment_npi_id)
    end

    def self.setup_file(params)
      file = Util.value(params, :file)
      params[:file] = File.new(file, 'rb') if file.is_a?(String)
    end

    def self.post(params, api_key = nil)
      setup_file(params)
      send_request(:post, original_signature_pdf_url(params), api_key, params, :enrollment_npi_id)
    end

    def self.update(params, api_key = nil)
      setup_file(params)
      send_request(:put, original_signature_pdf_url(params), api_key, params, :enrollment_npi_id)
    end

    def self.delete(params, api_key = nil)
      send_request(:delete, original_signature_pdf_url(params), api_key, params, :enrollment_npi_id)
    end

    def self.download(params, api_key = nil)
      enrollment_npi_id = Util.value(params, :enrollment_npi_id)
      require_param(enrollment_npi_id, 'Enrollment Npi id')
      params[:format] = 'x12'
      response = Eligible.request(:get, "/enrollment_npis/#{enrollment_npi_id}/original_signature_pdf/download", api_key, params)[0]
      filename = params[:filename] || '/tmp/original_signature_pdf.pdf'
      file = File.new(filename, 'w')
      file.write response
      file.close
      "PDF file stored at #{filename}"
    end
  end
end
