require 'spec_helper'

describe 'Coverage' do
  let(:params) { {test: true} }
  let(:api_key) { 'xyz' }
  let(:response) { {success: true} }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/coverage/all.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Coverage.get(params, api_key)).to eq 'success'
    end
  end

  describe '.cost_estimate' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/coverage/cost_estimates.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Coverage.cost_estimate(params, api_key)).to eq 'success'
    end
  end

  describe '.batch_post' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/coverage/all/batch.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Coverage.batch_post(params, api_key)).to eq 'success'
    end
  end

  describe '.batch_medicare_post' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/medicare/coverage/batch.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Coverage.batch_medicare_post(params, api_key)).to eq 'success'
    end
  end
end