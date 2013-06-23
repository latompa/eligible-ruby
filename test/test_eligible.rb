require File.expand_path('../test_helper', __FILE__)
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'rest-client'

class TestEligible < Test::Unit::TestCase
  include Mocha

  context 'Version' do
    should 'have a version number' do
      assert_not_nil Eligible::VERSION
    end
  end

  context' "General API"' do
    setup do
      Eligible.api_key = 'TEST'
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should 'not specifying api credentials should raise an exception' do
      Eligible.api_key = nil
      assert_raises Eligible::AuthenticationError do
        Eligible::Plan.get({})
      end
    end

    should 'specifying invalid api credentials should raise an exception' do
      Eligible.api_key = 'invalid'
      response = test_response(test_invalid_api_key_error, 401)
      assert_raises Eligible::AuthenticationError do
        @mock.expects(:get).once.raises(RestClient::ExceptionWithResponse.new(response, 401))
        Eligible::Plan.get({})
      end
    end
  end

  context 'Plan' do
    setup do
      Eligible.api_key = 'TEST'
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should 'return an error if no params are supplied' do
      params = {}
      response = test_response(test_plan_missing_params)
      @mock.expects(:get).returns(response)
      plan = Eligible::Plan.get(params)
      assert_not_nil plan.error
    end

    should 'return plan information if valid params are supplied' do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :provider_last_name => "Last",
        :provider_first_name => "First",
        :provider_npi => "1028384219",
        :member_id => "W120923801",
        :member_last_name => "Austen",
        :member_first_name => "Jane",
        :member_dob => "1955-12-14"
      }
      response = test_response(test_plan)
      @mock.expects(:get).returns(response)
      plan = Eligible::Plan.get(params)
      assert_nil plan.error
      assert_not_nil plan.all
    end

    should 'return the right subsets of the data when requested' do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :provider_last_name => "Last",
        :provider_first_name => "First",
        :provider_npi => "1028384219",
        :member_id => "W120923801",
        :member_last_name => "Austen",
        :member_first_name => "Jane",
        :member_dob => "1955-12-14"
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

  context 'Service' do
    setup do
      Eligible.api_key = 'TEST'
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should 'return an error if no params are supplied' do
      params = {}
      response = test_response(test_service_missing_params)
      @mock.expects(:get).returns(response)
      service = Eligible::Service.get(params)
      assert_not_nil service.error
    end

    should 'return eligibility information if valid params are supplied' do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :provider_last_name => "Last",
        :provider_first_name => "First",
        :provider_npi => "1028384219",
        :member_id => "W120923801",
        :member_last_name => "Austen",
        :member_first_name => "Jane",
        :member_dob => "1955-12-14"
      }
      response = test_response(test_service)
      @mock.expects(:get).returns(response)
      service = Eligible::Service.get(params)
      assert_nil service.error
      assert_not_nil service.all
    end

    should 'return the right subsets of the data when requested' do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :provider_last_name => "Last",
        :provider_first_name => "First",
        :provider_npi => "1028384219",
        :member_id => "W120923801",
        :member_last_name => "Austen",
        :member_first_name => "Jane",
        :member_dob => "1955-12-14"
      }
      response = test_response(test_service)
      @mock.expects(:get).returns(response)
      service = Eligible::Service.get(params)

      assert_not_nil  service.all[:service_begins]
      assert_not_nil  service.visits[:visits_in_network]
      assert_nil      service.visits[:copayment_in_network]
      assert_not_nil  service.copayment[:copayment_in_network]
      assert_nil      service.copayment[:visits_in_network]
      assert_not_nil  service.coinsurance[:coinsurance_in_network]
      assert_nil      service.coinsurance[:visits_in_network]
      assert_not_nil  service.deductible[:deductible_in_network]
      assert_nil      service.deductible[:visits_in_network]
    end
  end

  context 'Demographic' do
    setup do
      Eligible.api_key = 'TEST'
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should 'return an error if no params are supplied' do
      params = {}
      response = test_response(test_demographic_missing_params)
      @mock.expects(:get).returns(response)
      demographic = Eligible::Demographic.get(params)
      assert_not_nil demographic.error
    end

    should 'return demographic information if valid params are supplied' do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :provider_last_name => "Last",
        :provider_first_name => "First",
        :provider_npi => "1028384219",
        :member_id => "W120923801",
        :member_last_name => "Austen",
        :member_first_name => "Jane",
        :member_dob => "1955-12-14"
      }
      response = test_response(test_demographic)
      @mock.expects(:get).returns(response)
      demographic = Eligible::Demographic.get(params)
      assert_nil demographic.error
      assert_not_nil demographic.all
    end

    should 'return the right subsets of the data when requested' do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :provider_last_name => "Last",
        :provider_first_name => "First",
        :provider_npi => "1028384219",
        :member_id => "W120923801",
        :member_last_name => "Austen",
        :member_first_name => "Jane",
        :member_dob => "1955-12-14"
      }
      response = test_response(test_demographic)
      @mock.expects(:get).returns(response)
      demographic = Eligible::Demographic.get(params)

      assert_not_nil  demographic.all[:timestamp]
      assert_not_nil  demographic.zip[:zip]
      assert_nil      demographic.zip[:group_id]
      assert_not_nil  demographic.employer[:group_id]
      assert_nil      demographic.employer[:zip]
      assert_not_nil  demographic.address[:address]
      assert_nil      demographic.address[:group_id]
      assert_not_nil  demographic.dob[:dob]
      assert_nil      demographic.dob[:address]
    end
  end

  context 'Claim' do
    setup do
      Eligible.api_key = 'TEST'
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should 'return an error if no params are supplied' do
      params = {}
      response = test_response(test_claim_missing_params)
      @mock.expects(:get).returns(response)
      claim = Eligible::Claim.get(params)
      assert claim["success"] == "false"
    end

    should 'post a claim' do
      params = {"api_key"=>"asdfsdfsd21132ddsfsdfd", "billing_provider"=>{"taxonomy_code"=>"332B00000X", "practice_name"=>"Jane Austen Practice", "npi"=>"1922222222", "address"=>{"street_line_1"=>"419 Fulton", "street_line_2"=>"", "city"=>"San Francisco", "state"=>"CA", "zip"=>"94102"}, "tin"=>"43291023", "insurance_provider_id"=>"129873210"}, "pay_to_provider"=>{"address"=>{"street_line_1"=>"", "street_line_2"=>"", "city"=>"", "state"=>"", "zip"=>""}}, "subscriber"=>{"last_name"=>"Franklin", "first_name"=>"Benjamin", "member_id"=>"W2832032427", "group_id"=>"455716", "group_name"=>"none", "dob"=>"1734-05-04", "gender"=>"M", "address"=>{"street_line_1"=>"435 Sugar Lane", "street_line_2"=>"", "city"=>"Sweet", "state"=>"OH", "zip"=>"436233127"}}, "payer"=>{"name"=>"AETNA", "id"=>"60054", "address"=>{"street_line_1"=>"Po Box 981106", "street_line_2"=>"", "city"=>"El Paso", "state"=>"TX", "zip"=>"799981222"}}, "dependent"=>{"relationship"=>"", "last_name"=>"", "first_name"=>"", "dob"=>"", "gender"=>"", "address"=>{"street_line_1"=>"", "street_line_2"=>"", "city"=>"", "state"=>"", "zip"=>""}}, "claim"=>{"total_charge_amount"=>"275", "claim_frequency"=>"1", "patient_signature_on_file"=>"Y", "provider_plan_participation"=>"A", "direct_payment_authorized"=>"Y", "release_of_information"=>"I", "service_lines"=>[{"line_number"=>"1", "service_start"=>"2013-03-07", "service_end"=>"2013-03-07", "authorization_code"=>"", "place_of_service"=>"11", "charge_amount"=>"275", "product_service"=>"99213", "qualifier"=>"HC", "description"=>"", "modifier_1"=>"", "diagnosis_1"=>"32723"}]}}
      response = test_response(test_post_claim)
    end
  end

  context 'Coverage' do
    setup do
      Eligible.api_key = 'TEST'
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should 'return an error if no params are supplied' do
      params = {}
      response = test_response(test_coverage_missing_params)
      @mock.expects(:get).returns(response)
      coverage = Eligible::Coverage.get(params)
      assert_not_nil coverage.error
    end

    should 'return coverage information if valid params are supplied' do
      params = {
        :payer_name => "Aetna",
        :payer_id   => "000001",
        :provider_last_name => "Last",
        :provider_first_name => "First",
        :provider_npi => "1028384219",
        :member_id => "W120923801",
        :member_last_name => "Austen",
        :member_first_name => "Jane",
        :member_dob => "1955-12-14"
      }
      response = test_response(test_coverage)
      @mock.expects(:get).returns(response)
      coverage = Eligible::Coverage.get(params)

      assert_not_nil coverage.all[:eligible_id]
    end
  end

  context 'Enrollment' do
    setup do
      Eligible.api_key = 'TEST'
      @mock = mock
      Eligible.mock_rest_client = @mock
    end

    teardown do
      Eligible.mock_rest_client = nil
      Eligible.api_key = nil
    end

    should 'post an enrollment request' do
      params = {"service_provider_list"=>[{"facility_name"=>"Quality", "provider_name"=>"Jane Austen", "tax_id"=>"12345678", "address"=>"125 Snow Shoe Road", "city"=>"Sacramento", "state"=>"CA", "zip"=>"94107", "ptan"=>"54321", "npi"=>"987654321"}, {"facility_name"=>"Aetna", "provider_name"=>"Jack Austen", "tax_id"=>"12345678", "address"=>"985 Snow Shoe Road", "city"=>"Menlo Park", "state"=>"CA", "zip"=>"94107", "ptan"=>"54321", "npi"=>"987654321"}], "payer_ids"=>["00431", "00282"]}
      response = test_response(test_post_enrollment)

      @mock.expects(:post).returns(response)
      enrollment = Eligible::Enrollment.post(params)

      assert_not_nil enrollment.all[:enrollment_request]
    end

    should 'get the status of an enrollment request' do
      params = { "NPI" => "1028384219" }
      response = test_response(test_get_enrollment)
      @mock.expects(:get).returns(response)
      enrollment = Eligible::Enrollment.get(params)
      assert_not_nil enrollment.all[:enrollments]
    end
  end
end
