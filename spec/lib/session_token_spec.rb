describe Eligible::SessionToken do
  let(:params)   {
    {
      ttl_seconds: 60,
      max_calls: 1,
      endpoints: "coverage,cost_estimates,payer_list",
      test: true
    }
  }
  let(:api_key)  { 'xyz' }
  let(:response) { {success: true} }

  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.create' do
    it 'calls Eligible.request with proper url' do
      params[:reference_id] = '123'
      allow(Eligible).to receive(:request).with(:post, '/session_tokens/create.json', api_key, params).and_return([response, api_key])
      expect(Eligible::SessionToken.create(params, api_key)).to eq('success')
    end
  end
end
