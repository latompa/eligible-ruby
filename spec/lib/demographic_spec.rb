require 'spec_helper'

describe 'Eligible::Demographic' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/demographic/all.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Demographic.get(params, api_key)).to eq 'success'
    end
  end

  describe '.batch_post' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/demographic/all/batch.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Demographic.batch_post(params, api_key)).to eq 'success'
    end
  end
end
