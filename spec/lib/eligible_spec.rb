require 'spec_helper'

describe Eligible do
  it 'has a version number' do
    expect(Eligible::VERSION).to_not be_nil
  end

  context "Connection" do
    it 'fails when certificate presented does not match embedded fingerprint' do
      Eligible.api_key = "foo"
      allow(Eligible).to receive(:valid_fingerprint?).and_return(false)
      expect { Eligible::Coverage.get({}) }.to raise_error(Eligible::APIConnectionError)
    end

    it 'warns when the fingerprint is overridden' do
      expect { Eligible.add_fingerprint('foo') }.to output("The embedded certificate fingerprint was modified. This should only be done if instructed to by eligible support staff\n").to_stderr
    end

    it 'raises an error when api credentials are not provided' do
      Eligible.api_key = nil
      expect { Eligible::Coverage.get({}) }.to raise_error(Eligible::AuthenticationError)
    end
  end
end
