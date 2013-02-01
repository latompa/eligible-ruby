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

def test_plan
  {"timestamp"=>"2013-01-14T20:39:57", "eligible_id"=>"B97BC91A-3E84-40A9-AA5C-D416CAE5CDB1", "mapping_version"=>"plan/all$Revision:6$$Date:13-01-110:18$", "primary_insurance"=>{"name"=>"Aetna", "id"=>"00002", "group_name"=>"TOWERGROUPCOMPANIES", "plan_begins"=>"2010-01-01", "plan_ends"=>"", "comments"=>["AetnaChoicePOSII"]}, "type"=>"30", "coverage_status"=>"1", "precertification_needed"=>"", "exclusions"=>"", "deductible_in_network"=>{"individual"=>{"base_period"=>"500", "remaining"=>"500", "comments"=>["MedDent", "MedDent"]}, "family"=>{"base_period"=>"1000", "remaining"=>"1000", "comments"=>["MedDent", "MedDent"]}}, "deductible_out_network"=>{"individual"=>{"base_period"=>"1250", "remaining"=>"1250", "comments"=>["MedDent", "MedDent"]}, "family"=>{"base_period"=>"3750", "remaining"=>"3750", "comments"=>["MedDent", "MedDent"]}}, "stop_loss_in_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"2000", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"4000", "comments"=>[]}}, "stop_loss_out_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"3000", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"6000", "comments"=>[]}}, "balance"=>"", "comments"=>[], "additional_insurance"=>{"comments"=>[]}}
end