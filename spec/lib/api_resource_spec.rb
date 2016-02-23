describe 'API Resource' do
  it 'has a class name' do
    expect(Eligible::APIResource.class_name).to eq 'APIResource'
  end

  describe '.url' do
    it 'raises exception when it is called from APIResource class' do
      expect { Eligible::APIResource.url }.to raise_error(NotImplementedError)
    end

    it 'should return valid url for subclasses' do
      class Test < Eligible::APIResource
      end
      expect(Test.url).to eq "/test/"
    end
  end

  describe '.require_param' do
    it 'should raise error if param is empty string' do
      expect { Eligible::APIResource.require_param('', 'test') }.to raise_error(ArgumentError)
    end

    it 'should raise error if param is nil' do
      expect { Eligible::APIResource.require_param(nil, 'test') }.to raise_error(ArgumentError)
    end

    it 'should not raise error if param is number' do
      expect { Eligible::APIResource.require_param(123, 'test') }.not_to raise_error
    end

    it 'should not raise error if param is present' do
      expect { Eligible::APIResource.require_param("123", 'test') }.not_to raise_error
    end
  end

  describe '.send_request' do
    let(:params) { { test: true } }
    let(:api_key) { 'xyz' }
    let(:response) { { success: true } }
    let(:url) { '/test/url' }
    before(:each) do
      allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
    end

    it 'should not raise error if required param is present' do
      params[:reference_id] = '123'
      allow(Eligible).to receive(:request).with(:get, url, api_key, params).and_return([response, api_key])
      expect(Eligible::APIResource.send_request(:get, url, api_key, params, :reference_id)).to eq 'success'
    end

    it 'should raise error if required param is not present' do
      expect { Eligible::APIResource.send_request(:get, url, api_key, params, :reference_id) }.to raise_error(ArgumentError)
    end
  end
end
