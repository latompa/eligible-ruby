module Eligible
  class OriginalSignaturePdf < APIResource
    def self.get(params, api_key = nil)
      response, api_key = Eligible.request(:get, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.post(params, api_key = nil)
      response, api_key = Eligible.request(:post, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.update(params, api_key = nil)
      response, api_key = Eligible.request(:put, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.delete(params, api_key = nil)
      response, api_key = Eligible.request(:delete, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf", api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.download(params, api_key = nil)
      response, api_key = Eligible.request(:get, "/enrollment_npis/#{params[:enrollment_npi_id]}/original_signature_pdf/download", api_key, params)
      filename = params[:filename] || "original_signature_pdf.pdf"
      file = File.new(filename, "w")
      file.write response
      file.close
    end
  end
end