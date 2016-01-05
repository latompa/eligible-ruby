require 'spec_helper'

describe Eligible do
  it 'fails when certificate presented does not match embedded fingerprint' do
    Eligible.api_key = "doesn't matter"
    allow(Eligible).to receive(:valid_fingerprint?).and_return(false)
    expect { Eligible::Coverage.get({}) }.to raise_error(Eligible::APIConnectionError)
  end
end
