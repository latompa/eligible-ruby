describe 'Eligible::Precert' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.inquiry' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/precert/inquiry.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Precert.inquiry(params, api_key)).to eq 'success'
    end
  end

  describe '.require' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/precert/require.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Precert.require(params, api_key)).to eq 'success'
    end
  end

  describe '.create' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/precert/create.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Precert.create(params, api_key)).to eq 'success'
    end
  end
end
