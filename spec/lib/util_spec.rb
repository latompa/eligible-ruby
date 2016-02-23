require 'spec_helper'

describe 'Eligible::Util' do
  describe '.convert_to_eligible_object' do
    context 'when response is Array' do
      it 'should create Enrollment object when response is array and it has enrollment_npi' do
        response = [{ enrollment_npi: { npi: 1234567893 } }]
        eligible_obj = Eligible::Util.convert_to_eligible_object(response, nil)
        expect(eligible_obj.class.name).to eq "Eligible::Enrollment"
      end

      it 'should call convert_to_eligible_object recursively for all array elements' do
        response = [{ success: true }, { success: false }]
        eligible_obj = Eligible::Util.convert_to_eligible_object(response, nil)
        expect(eligible_obj[0].class.name).to eq "Eligible::EligibleObject"
        expect(eligible_obj[1].class.name).to eq "Eligible::EligibleObject"
      end
    end

    context 'when response is hash' do
      it 'should create enrollment object when key enrollment_npi is present' do
        response = { enrollment_npi: { npi: 1234567893 } }
        eligible_obj = Eligible::Util.convert_to_eligible_object(response, nil)
        expect(eligible_obj.class.name).to eq "Eligible::Enrollment"
      end

      it 'should create coverage object when key demographics is present' do
        response = { demographics: { test: true } }
        eligible_obj = Eligible::Util.convert_to_eligible_object(response, nil)
        expect(eligible_obj.class.name).to eq "Eligible::Coverage"
      end

      it 'should create demographic object when keys subscriber and dependent are present' do
        response = { subscriber: { test: true }, dependent: { test: true } }
        eligible_obj = Eligible::Util.convert_to_eligible_object(response, nil)
        expect(eligible_obj.class.name).to eq "Eligible::Demographic"
      end

      it 'should create eligible object for all others' do
        response = { test: true }
        eligible_obj = Eligible::Util.convert_to_eligible_object(response, nil)
        expect(eligible_obj.class.name).to eq "Eligible::EligibleObject"
      end
    end

    context 'when response is string' do
      it 'should return response as it is when it is string' do
        response = "X12:Message"
        eligible_obj = Eligible::Util.convert_to_eligible_object(response, nil)
        expect(eligible_obj).to eq response
      end
    end
  end

  describe '.symbolize_names' do
    it 'should symbolize the hash' do
      params = { 'test' => { 'a' => 'true' } }
      expect(Eligible::Util.symbolize_names(params)).to eq ({ test: { a: 'true' } })
    end

    it 'should symbolize the array' do
      params = [ { 'test' => 'true' }, { 'a' => 'true' } ]
      expect(Eligible::Util.symbolize_names(params)).to eq ([ { test: 'true'}, { a: "true" } ])
    end

    it 'should not fail if hash keys could not be converted to a symbol' do
      params = { 1 => 'foo', false => 'bar' }
      expect(Eligible::Util.symbolize_names(params)).to eq ({ 1 => 'foo', false => 'bar' })
    end

    it 'should return non-container values as-is' do
      expect(Eligible::Util.symbolize_names('test')).to eq('test')
      expect(Eligible::Util.symbolize_names(0)).to eq(0)
      expect(Eligible::Util.symbolize_names(false)).to eq(false)
    end
  end

  describe '.url_encode' do
    it 'should encode the url' do
      expect(Eligible::Util.url_encode('abc&def')).to eq 'abc%26def'
    end
  end

  describe '.flatten_params' do
    it 'should flatten the params' do
      params = {test: { x: 'a&b', y: ['c&d'] } }
      expect(Eligible::Util.flatten_params(params)).to eq [["test[x]", "a&b"], ["test[y][0]", "c&d"]]
    end
  end

  describe '.flatten_params_array' do
    it 'should flatten the params' do
      params = [ 'a&b', 'c&d' ]
      expect(Eligible::Util.flatten_params_array(params, 'test')).to eq [["test[0]", "a&b"], ["test[1]", "c&d"]]
    end
  end
end
