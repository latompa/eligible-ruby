require 'spec_helper'

describe 'Eligible::Payer' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      params[:payer_id] = 12345
      allow(Eligible).to receive(:request).with(:get, '/payers/12345.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Payer.get(params, api_key)).to eq 'success'
    end

    it 'should raise error if customer id is not present' do
      expect{ Eligible::Payer.get(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.list' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/payers.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Payer.list(params, api_key)).to eq 'success'
    end
  end

  describe '.search_options' do
    it 'should call Eligible.request with proper url when payer id is present' do
      params[:payer_id] = 12345
      allow(Eligible).to receive(:request).with(:get, '/payers/12345/search_options', api_key, params).and_return([response, api_key])
      expect(Eligible::Payer.search_options(params, api_key)).to eq 'success'
    end

    it 'should call Eligible.request with proper url when payer id is not present' do
      allow(Eligible).to receive(:request).with(:get, '/payers/search_options', api_key, params).and_return([response, api_key])
      expect(Eligible::Payer.search_options(params, api_key)).to eq 'success'
    end
  end
end
