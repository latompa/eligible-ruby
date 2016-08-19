describe 'Eligible::PublicKey' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      params[:key_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/public_keys/123.json', api_key, params).and_return([response, api_key])
      expect(Eligible::PublicKey.get(params, api_key)).to eq 'success'
    end

    it 'should raise error if key id is not present' do
      expect { Eligible::PublicKey.get(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.post' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/public_keys.json', api_key, params).and_return([response, api_key])
      expect(Eligible::PublicKey.post(params, api_key)).to eq 'success'
    end
  end

  describe '.activate' do
    it 'should call Eligible.request with proper url' do
      params[:key_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/public_keys/123/activate.json', api_key, params).and_return([response, api_key])
      expect(Eligible::PublicKey.activate(params, api_key)).to eq 'success'
    end

    it 'should raise error if key id is not present' do
      expect { Eligible::PublicKey.activate(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.all' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/public_keys.json', api_key, params).and_return([response, api_key])
      expect(Eligible::PublicKey.all(params, api_key)).to eq 'success'
    end
  end
end
