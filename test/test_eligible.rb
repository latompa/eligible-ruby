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

  context "General API" do
    setup do
      Eligible.api_key = "TEST"
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should "not specifying api credentials should raise an exception" do
      Eligible.api_key = nil
      assert_raises Eligible::AuthenticationError do
        Eligible::Plan.all({})
      end
    end

    should "specifying invalid api credentials should raise an exception" do
      Eligible.api_key = "invalid"
      response = test_response(test_invalid_api_key_error, 401)
      assert_raises Eligible::AuthenticationError do
        @mock.expects(:get).once.raises(RestClient::ExceptionWithResponse.new(response, 401))
        Eligible::Plan.all({})
      end
    end
  end

  context "Plan" do
    setup do
      Eligible.api_key = "TEST"
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should "return plan information" do
      params = {}
      response = test_response(test_plan)
      @mock.expects(:get).returns(response)
      plan = Eligible::Plan.all(params)
      assert_not_nil plan[:timestamp]
    end
  end

end
