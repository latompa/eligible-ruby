describe 'Eligible::Enrollment' do
  let(:params) { { test: true } }
  let(:api_key) { 'xyz' }
  let(:response) { { success: true } }
  before(:each) do
    allow(Eligible::Util).to receive(:convert_to_eligible_object).with(response, api_key).and_return('success')
  end

  describe '.get' do
    it 'should call Eligible.request with proper url' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:get, '/enrollment_npis/123.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Enrollment.get(params, api_key)).to eq 'success'
    end

    it 'should raise error if enrollment npi id is not present' do
      expect { Eligible::Enrollment.get(params, api_key) }.to raise_error(ArgumentError)
    end
  end

  describe '.post' do
    it 'should post to Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:post, '/enrollment_npis.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Enrollment.post(params, api_key)).to eq 'success'
    end
  end

  describe '.list' do
    it 'should call Eligible.request with proper url' do
      allow(Eligible).to receive(:request).with(:get, '/enrollment_npis.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Enrollment.list(params, api_key)).to eq 'success'
    end
  end

  describe '.update' do
    it 'should call Eligible.request with proper url' do
      params[:enrollment_npi_id] = 123
      allow(Eligible).to receive(:request).with(:put, '/enrollment_npis/123.json', api_key, params).and_return([response, api_key])
      expect(Eligible::Enrollment.update(params, api_key)).to eq 'success'
    end

    it 'should raise error if enrollment npi id is not present' do
      expect { Eligible::Enrollment.update(params, api_key) }.to raise_error(ArgumentError)
    end
  end
end

describe '#enrollment_npis' do
  it 'should return enrollment npi' do
    response = { enrollment_npis: [{ enrollment_npi: { npi: 1234567893 } }] }
    enrollment_object = Eligible::Util.convert_to_eligible_object(response, nil)
    expect(enrollment_object.enrollment_npis).to eq([{ enrollment_npi: { npi: 1234567893 } }])
  end
end
