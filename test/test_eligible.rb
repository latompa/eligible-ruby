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
        Eligible::Plan.get({})
      end
    end

    should "specifying invalid api credentials should raise an exception" do
      Eligible.api_key = "invalid"
      response = test_response(test_invalid_api_key_error, 401)
      assert_raises Eligible::AuthenticationError do
        @mock.expects(:get).once.raises(RestClient::ExceptionWithResponse.new(response, 401))
        Eligible::Plan.get({})
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

    should "return an error if no params are supplied" do
      params = {}
      response = test_response(test_plan_missing_params)
      @mock.expects(:get).returns(response)
      plan = Eligible::Plan.get(params)
      assert_not_nil plan.error
    end

    should "return plan information if valid params are supplied" do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :service_provider_last_name => "Last",
        :service_provider_first_name => "First",
        :service_provider_NPI => "1928384219",
        :subscriber_id => "W120923801",
        :subscriber_last_name => "Austen",
        :subscriber_first_name => "Jane",
        :subscriber_dob => "1955-12-14"
      }
      response = test_response(test_plan)
      @mock.expects(:get).returns(response)
      plan = Eligible::Plan.get(params)
      assert_nil plan.error
      assert_not_nil plan.all
    end

    should "return the right subsets of the data when requested" do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :service_provider_last_name => "Last",
        :service_provider_first_name => "First",
        :service_provider_NPI => "1928384219",
        :subscriber_id => "W120923801",
        :subscriber_last_name => "Austen",
        :subscriber_first_name => "Jane",
        :subscriber_dob => "1955-12-14"
      }
      response = test_response(test_plan)
      @mock.expects(:get).returns(response)
      plan = Eligible::Plan.get(params)

      assert_not_nil  plan.all[:primary_insurance]
      assert_not_nil  plan.status[:coverage_status]
      assert_nil      plan.status[:deductible_in_network]
      assert_not_nil  plan.deductible[:deductible_in_network]
      assert_nil      plan.deductible[:balance]
      assert_not_nil  plan.dates[:primary_insurance][:plan_begins]
      assert_nil      plan.dates[:deductible_in_network]
      assert_not_nil  plan.balance[:balance]
      assert_nil      plan.balance[:deductible_in_network]
      assert_not_nil  plan.stop_loss[:stop_loss_in_network]
      assert_nil      plan.stop_loss[:deductible_in_network]
    end
  end

end
