require File.expand_path('../test_helper', __FILE__)
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'rest-client'


class TestEligible < Test::Unit::TestCase
  include Mocha

  context "Version" do
    should "have a version number" do
      assert_not_nil Eligible::VERSION
    end
  end

  context "Plan" do
    setup do
      Eligible.api_key = "TEST"
    end

    should "return plan information" do
      params = {}
      plan = Eligible::Plan.all(params)
      assert_not_nil plan.timestamp
    end
  end

end
