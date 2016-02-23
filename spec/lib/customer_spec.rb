require 'spec_helper'

describe 'Eligible::Customer' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      params[:customer_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/customers/123.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Customer.get(params, api_key)).to eq 'success'
    end

    it 'should raise error if customer id is not present' do
      expect { Eligible::Customer.get(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.post' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/customers.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Customer.post(params, api_key)).to eq 'success'
    end
  end

  describe '.update' do
    it 'should call Eligible.request with proper url' do
      params[:customer_id] = 123
      allow(Eligible).to receive(:request).with(:put, '/customers/123.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Customer.update(params, api_key)).to eq 'success'
    end

    it 'should raise error if customer id is not present' do
      expect { Eligible::Customer.update(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.all' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/customers.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Customer.all(params, api_key)).to eq 'success'
    end
  end
end
