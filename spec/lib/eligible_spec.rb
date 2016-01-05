require 'spec_helper'

describe Eligible do
  it 'fails when certificate presented does not match embedded fingerprint' do
    Eligible.api_key = "doesn't matter"
    allow(Eligible).to receive(:valid_fingerprint?).and_return(false)
    expect { Eligible::Coverage.get({}) }.to raise_error(Eligible::APIConnectionError)
  end

  it 'warns when the fingerprint is overridden' do
    expect { Eligible.fingerprint='foo' }.to output("The embedded certificate fingerprint was modified. This should only be done if instructed to by eligible support staff\n").to_stderr
  end
end
