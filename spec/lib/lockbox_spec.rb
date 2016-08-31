describe 'Eligible::Lockbox' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      params[:lockbox_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/lockboxes/123.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Lockbox.get(params, api_key)).to eq 'success'
    end

    it 'should raise error if lockbox id is not present' do
      expect { Eligible::Lockbox.get(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.all' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/lockboxes.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Lockbox.all(params, api_key)).to eq 'success'
    end
  end

  describe '.extract_private_key' do
    it 'should return private key from the params' do
      params[:private_key] = 'xyz'
      expect(Eligible::Lockbox.extract_private_key(params)).to eq 'xyz'
    end

    it 'should return private key if it is present as string in params' do
      params['private_key'] = 'xyz'
      expect(Eligible::Lockbox.extract_private_key(params)).to eq 'xyz'
    end

    it 'should raise error if private key is not present' do
      expect { Eligible::Lockbox.extract_private_key(params) }.to raise_error(ArgumentError)
    end
  end

  describe '.delete_private_key!' do
    it 'should delete private key from the params' do
      params[:private_key] = 'xyz'
      params['private_key'] = 'abc'
      Eligible::Lockbox.delete_private_key!(params)
      expect(params).to eq ({ test: true })
    end
  end

  describe '.decrypt_data' do
    it 'should call private_decrypt on the data' do
      pkey = instance_double('OpenSSL::PKey::RSA')
      allow(OpenSSL::PKey::RSA).to receive(:new).and_return(pkey)
      expect(pkey).to receive(:private_decrypt).and_return('aws')
      expect(Eligible::Encryptor).to receive(:decrypt)
      Eligible::Lockbox.decrypt_data('test', 'abc', 'xyz')
    end
  end

  describe '.get_and_decrypt_from_lockbox' do
    it 'should get the data and decrypt it using private key' do
      params[:private_key] = 'xyz'
      returned_obj = instance_double('EligibleObject')
      allow(Eligible::Lockbox).to receive(:get).and_return(returned_obj)
      allow(returned_obj).to receive(:to_hash).and_return({ encrypted_data: 'test', encrypted_key: 'abc' })
      expect(Eligible::Lockbox).to receive(:decrypt_data).with('test', 'abc', 'xyz')
      Eligible::Lockbox.get_and_decrypt_from_lockbox(params)
    end

    it 'should return error if private key is not present in params' do
      expect { Eligible::Lockbox.get_and_decrypt_from_lockbox(params) }.to raise_error(ArgumentError)
    end
  end
end
