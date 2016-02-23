require 'spec_helper'

describe 'Eligible::OriginalSignaturePdf' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/enrollment_npis/123/original_signature_pdf', api_key, params).and_return([response, api_key])
      expect(Eligible::OriginalSignaturePdf.get(params, api_key)).to eq 'success'
    end

    it 'should raise error if enrollment npi id is not present' do
      expect{ Eligible::OriginalSignaturePdf.get(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.post' do
    it 'should post to Eligible.request with proper url' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:post, '/enrollment_npis/123/original_signature_pdf', api_key, params).and_return([response, api_key])
      expect(Eligible::OriginalSignaturePdf.post(params, api_key)).to eq 'success'
    end

    it 'should raise error if enrollment npi id is not present' do
      expect{ Eligible::OriginalSignaturePdf.post(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.update' do
    it 'should call Eligible.request with proper url' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:put, '/enrollment_npis/123/original_signature_pdf', api_key, params).and_return([response, api_key])
      expect(Eligible::OriginalSignaturePdf.update(params, api_key)).to eq 'success'
    end

    it 'should raise error if enrollment npi id is not present' do
      expect{ Eligible::OriginalSignaturePdf.update(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.delete' do
    it 'should call Eligible.request with proper url' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:delete, '/enrollment_npis/123/original_signature_pdf', api_key, params).and_return([response, api_key])
      expect(Eligible::OriginalSignaturePdf.delete(params, api_key)).to eq 'success'
    end

    it 'should raise error if enrollment npi id is not present' do
      expect{ Eligible::OriginalSignaturePdf.delete(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.download' do
    it 'should download to original_signature_pdf.pdf' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/enrollment_npis/123/original_signature_pdf/download', api_key, params).and_return([response, api_key])
      Eligible::OriginalSignaturePdf.download(params, api_key)
      expect(File.read('/tmp/original_signature_pdf.pdf')).to eq response.to_s
      File.delete('/tmp/original_signature_pdf.pdf')
    end

    it 'should raise error if enrollment npi id is not present' do
      expect{ Eligible::OriginalSignaturePdf.delete(params, api_key) }.to raise_error(ArgumentError)
    end
  end
end
