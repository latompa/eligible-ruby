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
    require eligible
    Eligible.api_key = YOUR_KEY

### Retrieve Plan object and query it
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

    plan = Eligible::Plan.get(params)
    plan.all      # returns all fields on the plan, per the plan/all endpoint
    plan.status   # returns status fields on the plan, per the plan/status endpoint
    ## Etc.: plan.deductible, plan.dates, plan.balance, plan.stop_loss 

### Retrieve Service object and query it
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

    service = Eligible::Service.get(params)
    service.all     # returns all fields for the service, per service/all
    service.visits  # returns the visits for the service, per service/visits
    ## Etc.: service.copayment, service.coinsurance, service.deductible

### Retrieve Demographic object and query it
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

    demographic = Eligible::Demographic.get(params)
    demographic.all # returns all fields for the demographic, per demographic/all
    demographic.zip # returns the patient's zip code, per demographic/zip
    ## Etc.: demographic.employer, demographic.address, demographic.dob

### Retrieve Claim object

    params = {
      
    }    
    
    claim = Eligible::Claim.get(params)
    claim.status # Returns in real time the status (paid, not paid, rejected, denied, etc) of claim specified.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
