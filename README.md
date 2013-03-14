# Eligible

Ruby bindings for the [Eligible API](https://eligibleapi.com/rest-api-v1)

## Installation

Add this line to your application's Gemfile:

    gem 'eligible'

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install eligible

## Usage

### Setup
    require 'eligible'
    Eligible.api_key = YOUR_KEY

### Format

Include `{ :format => "X12" }` in the params hash to get back the raw X12 response.

### Retrieve Plan object and query it

```ruby
params = {
  :payer_name => "Aetna",
  :payer_id   => "000001",
  :service_provider_last_name => "Last",
  :service_provider_first_name => "First",
  :service_provider_NPI => "12345678",
  :subscriber_id => "12345678",
  :subscriber_last_name => "Austen",
  :subscriber_first_name => "Jane",
  :subscriber_dob => "1955-12-14"
}

plan = Eligible::Plan.get(params)
plan.all      # returns all fields on the plan, per the plan/all endpoint
plan.status   # returns status fields on the plan, per the plan/status endpoint
## Etc.: plan.deductible, plan.dates, plan.balance, plan.stop_loss 
```

### Retrieve Service object and query it

```ruby
params = {
  :payer_name => "Aetna",
  :payer_id   => "000001",
  :service_provider_last_name => "Last",
  :service_provider_first_name => "First",
  :service_provider_NPI => "12345678",
  :subscriber_id => "12345678",
  :subscriber_last_name => "Austen",
  :subscriber_first_name => "Jane",
  :subscriber_dob => "1955-12-14"
}

service = Eligible::Service.get(params)
service.all     # returns all fields for the service, per service/all
service.visits  # returns the visits for the service, per service/visits
## Etc.: service.copayment, service.coinsurance, service.deductible
```

### Retrieve Demographic object and query it

```ruby
params = {
  :payer_name => "Aetna",
  :payer_id   => "000001",
  :service_provider_last_name => "Last",
  :service_provider_first_name => "First",
  :service_provider_NPI => "12345678",
  :subscriber_id => "12345678",
  :subscriber_last_name => "Austen",
  :subscriber_first_name => "Jane",
  :subscriber_dob => "1955-12-14"
}

demographic = Eligible::Demographic.get(params)
demographic.all # returns all fields for the demographic, per demographic/all
demographic.zip # returns the patient's zip code, per demographic/zip
## Etc.: demographic.employer, demographic.address, demographic.dob
```

### Retrieve Claim object

```ruby
params = {
  :payer_name => "Aetna",
  :payer_id => "000001",
  :information_receiver_organization_name => "Organization",
  :information_receiver_last_name => "Last",
  :information_receiver_first_name => "First",
  :information_receiver_etin => "1386332",
  :service_provider_organization_name => "Marshall Group",
  :service_provider_last_name => "Last",
  :service_provider_first_name => "First",
  :service_provider_npi => "12345678",
  :service_provider_tax_id => "1386332",
  :subscriber_id => "12345678",
  :subscriber_last_name => "Last", 
  :subscriber_first_name => "First",
  :subscriber_dob => "1955-12-14",
  :dependent_last_name => "Last",
  :dependent_first_name => "First",
  :dependent_dob => "1975-12-14",
  :dependent_gender => "M",
  :trace_number => "12345",
  :claim_control_number => "67890",
  :claim_charge_amount => "45.00",
  :claim_start_date => "2013-01-05",
  :claim_end_date => "2013-01-05"
}    

claim = Eligible::Claim.get(params)
claim.status # Returns in real time the status (paid, not paid, rejected, denied, etc) of claim specified.
```

## Tests

You can run tests with 

```ruby
rake test
```

If you do send a pull request, please add passing tests for the new feature/fix.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run tests (see above)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

## Changelog

#### 1.1

- Additional endpoints for service/general and service/list
- Support x12 format in params

#### 1.0

Initial release