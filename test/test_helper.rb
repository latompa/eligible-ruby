$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'eligible'

module Eligible
  @mock_rest_client = nil

  def self.mock_rest_client=(mock_client)
    @mock_rest_client = mock_client
  end

  def self.execute_request(opts)
    get_params = (opts[:headers] || {})[:params]
    post_params = opts[:payload]
    case opts[:method]
    when :get then @mock_rest_client.get opts[:url], get_params, post_params
    when :post then @mock_rest_client.post opts[:url], get_params, post_params
    when :delete then @mock_rest_client.delete opts[:url], get_params, post_params
    end
  end
end

def test_response(body, code=200)
  # When an exception is raised, restclient clobbers method_missing.  Hence we
  # can't just use the stubs interface.
  body = MultiJson.dump(body) if !(body.kind_of? String)
  m = mock
  m.instance_variable_set('@eligible_values', { :body => body, :code => code })
  def m.body; @eligible_values[:body]; end
  def m.code; @eligible_values[:code]; end
  m
end  

def test_invalid_api_key_error
  { "error" => [ { "message" => "Could not authenticate you. Please re-try with a valid API key.", "code" => 1 }] }
end

def test_plan_missing_params
  {"timestamp"=>"2013-02-01T13:25:58", "eligible_id"=>"A4F4E1D6-7DC3-4B20-87CE-B59F48811290", "mapping_version"=>"plan/all$Revision:6$$Date:13-01-110:18$", "error"=>{"response_code"=>"Y", "response_description"=>"Yes", "agency_qualifier_code"=>"", "agency_qualifier_description"=>"", "reject_reason_code"=>"41", "reject_reason_description"=>"Authorization/AccessRestrictions", "follow-up_action_code"=>"C", "follow-up_action_description"=>"PleaseCorrectandResubmit"}}
end

def test_plan
  {"timestamp"=>"2013-01-14T20:39:57", "eligible_id"=>"B97BC91A-3E84-40A9-AA5C-D416CAE5CDB1", "mapping_version"=>"plan/all$Revision:6$$Date:13-01-110:18$", "primary_insurance"=>{"name"=>"Aetna", "id"=>"00002", "group_name"=>"TOWERGROUPCOMPANIES", "plan_begins"=>"2010-01-01", "plan_ends"=>"", "comments"=>["AetnaChoicePOSII"]}, "type"=>"30", "coverage_status"=>"1", "precertification_needed"=>"", "exclusions"=>"", "deductible_in_network"=>{"individual"=>{"base_period"=>"500", "remaining"=>"500", "comments"=>["MedDent", "MedDent"]}, "family"=>{"base_period"=>"1000", "remaining"=>"1000", "comments"=>["MedDent", "MedDent"]}}, "deductible_out_network"=>{"individual"=>{"base_period"=>"1250", "remaining"=>"1250", "comments"=>["MedDent", "MedDent"]}, "family"=>{"base_period"=>"3750", "remaining"=>"3750", "comments"=>["MedDent", "MedDent"]}}, "stop_loss_in_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"2000", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"4000", "comments"=>[]}}, "stop_loss_out_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"3000", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"6000", "comments"=>[]}}, "balance"=>"", "comments"=>[], "additional_insurance"=>{"comments"=>[]}}
end

def test_service_missing_params
  {"timestamp"=>"2013-02-04T17:23:12", "eligible_id"=>"7EEA40A7-58C5-4EBC-A450-10C37CA2D252", "mapping_version"=>"service/all$Revision:4$$Date:12-12-280:13$", "error"=>{"response_code"=>"Y", "response_description"=>"Yes", "agency_qualifier_code"=>"", "agency_qualifier_description"=>"", "reject_reason_code"=>"41", "reject_reason_description"=>"Authorization/AccessRestrictions", "follow-up_action_code"=>"C", "follow-up_action_description"=>"PleaseCorrectandResubmit"}}
end

def test_service
  {"timestamp"=>"2013-02-01T15:28:16", "eligible_id"=>"FD8994B1-F977-459A-81AC-D182EA8FE66D", "mapping_version"=>"service/all$Revision:4$$Date:12-12-280:13$", "type"=>"33", "coverage_status"=>"1", "service_begins"=>"", "service_ends"=>"", "not_covered"=>[], "comments"=>["AetnaChoicePOSII"], "precertification_needed"=>"", "visits_in_network"=>{"individual"=>{"total"=>"", "remaining"=>"", "comments"=>[]}, "family"=>{"total"=>"", "remaining"=>"", "comments"=>[]}}, "visits_out_network"=>{"individual"=>{"total"=>"", "remaining"=>"", "comments"=>[]}, "family"=>{"total"=>"", "remaining"=>"", "comments"=>[]}}, "copayment_in_network"=>{"individual"=>{"amount"=>"", "comments"=>[]}, "family"=>{"amount"=>"35", "comments"=>["OFFCHIROVISI", "COPAYNOTINCLUDEDINOOP", "MANPULATNCHRO"]}}, "copayment_out_network"=>{"individual"=>{"amount"=>"", "comments"=>[]}, "family"=>{"amount"=>"0", "comments"=>["MANPULATNCHRO"]}}, "coinsurance_in_network"=>{"individual"=>{"percent"=>"", "comments"=>[]}, "family"=>{"percent"=>"0", "comments"=>["OFFCHIROVISI", "MANPULATNCHRO"]}}, "coinsurance_out_network"=>{"individual"=>{"percent"=>"", "comments"=>[]}, "family"=>{"percent"=>"30", "comments"=>["CHIROVSTEVAL", "COINSAPPLIESTOOUTOFPOCKET", "MANPULATNCHRO"]}}, "deductible_in_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"", "comments"=>[]}}, "deductible_out_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"", "comments"=>[]}}, "additional_insurance"=>{"comments"=>[]}}
end