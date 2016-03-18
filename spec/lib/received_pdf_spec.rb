describe 'Eligible::ReceivedPdf' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/enrollment_npis/123/received_pdf', api_key, params).and_return([response, api_key])
      expect(Eligible::ReceivedPdf.get(params, api_key)).to eq 'success'
    end

    it 'should raise error if enrollment npi id is not present' do
      expect { Eligible::ReceivedPdf.get(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.download' do
    it 'should download to received_pdf.pdf' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/enrollment_npis/123/received_pdf/download', api_key, params).and_return([response, api_key])
      Eligible::ReceivedPdf.download(params, api_key)
      expect(File.read('/tmp/received_pdf.pdf')).to eq response.to_s
      File.delete('/tmp/received_pdf.pdf')
    end

    it 'should raise error if enrollment npi id is not present' do
      expect { Eligible::ReceivedPdf.download(params, api_key) }.to raise_error(ArgumentError)
    end
  end
end
