require 'spec_helper'

describe 'Eligible::Ticket' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      params[:id] = 123
      allow(Eligible).to receive(:request).with(:get, '/tickets/123', api_key, params).and_return([response, api_key])
      expect(Eligible::Ticket.get(params, api_key)).to eq 'success'
    end

    it 'should raise error if ticket id is not present' do
      expect { Eligible::Ticket.get(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.delete' do
    it 'should call Eligible.request with proper url' do
      params[:id] = 123
      allow(Eligible).to receive(:request).with(:delete, '/tickets/123', api_key, params).and_return([response, api_key])
      expect(Eligible::Ticket.delete(params, api_key)).to eq 'success'
    end

    it 'should raise error if ticket id is not present' do
      expect { Eligible::Ticket.delete(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.comments' do
    it 'should call Eligible.request with proper url' do
      params[:id] = 123
      allow(Eligible).to receive(:request).with(:post, '/tickets/123/comments', api_key, params).and_return([response, api_key])
      expect(Eligible::Ticket.comments(params, api_key)).to eq 'success'
    end

    it 'should raise error if ticket id is not present' do
      expect { Eligible::Ticket.comments(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.create' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/tickets', api_key, params).and_return([response, api_key])
      expect(Eligible::Ticket.create(params, api_key)).to eq 'success'
    end
  end

  describe '.update' do
    it 'should call Eligible.request with proper url' do
      params[:id] = 123
      allow(Eligible).to receive(:request).with(:put, '/tickets/123', api_key, params).and_return([response, api_key])
      expect(Eligible::Ticket.update(params, api_key)).to eq 'success'
    end

    it 'should raise error if ticket id is not present' do
      expect { Eligible::Ticket.update(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.all' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/tickets', api_key, params).and_return([response, api_key])
      expect(Eligible::Ticket.all(params, api_key)).to eq 'success'
    end
  end
end
