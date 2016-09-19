describe Eligible::Payment do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/payment/status.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Payment.get(params, api_key)).to eq 'success'
    end
  end

  describe '.batch' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/batch/payment/status.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Payment.batch(params, api_key)).to eq 'success'
    end
  end
end
