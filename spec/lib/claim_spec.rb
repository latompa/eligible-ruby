require 'spec_helper'

describe 'Claim' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.ack' do
    it 'should call Eligible.request with proper url' do
      params[:reference_id] = '123'
      allow(Eligible).to receive(:request).with(:get, '/claims/123/acknowledgements.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Claim.ack(params, api_key)).to eq 'success'
    end

    it 'should raise error if reference id is not present' do
      expect{ Eligible::Claim.ack(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.post' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/claims.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Claim.post(params, api_key)).to eq 'success'
    end
  end

  describe '.acks' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/claims/acknowledgements.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Claim.acks(params, api_key)).to eq 'success'
    end
  end

  describe '.payment_report' do
    it 'should call Eligible.request with proper url when only reference id is given' do
      params[:reference_id] = '123'
      allow(Eligible).to receive(:request).with(:get, '/claims/123/payment_reports', api_key, params).and_return([response, api_key])
      expect(Eligible::Claim.payment_report(params, api_key)).to eq 'success'
    end

    it 'should call Eligible.request with proper url when both reference id and id are given' do
      params[:reference_id] = '123'
      params[:id] = 'ABC'
      allow(Eligible).to receive(:request).with(:get, '/claims/123/payment_reports/ABC', api_key, params).and_return([response, api_key])
      expect(Eligible::Claim.payment_report(params, api_key)).to eq 'success'
    end

    it 'should raise error if reference id is not present' do
      expect{ Eligible::Claim.payment_report(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.payment_reports' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/claims/payment_reports.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Claim.payment_reports(params, api_key)).to eq 'success'
    end
  end
end
