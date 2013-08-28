# Eligible

Ruby bindings for the [Eligible API](https://eligibleapi.com/rest-api-v1)

## Installation

Add this line to your application's Gemfile:

    gem 'eligible'

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install eligible

# Usage

### Setup
```ruby
    require 'eligible'
    Eligible.api_key = 'YOUR_KEY'
```

### Test
```ruby
Eligible.test = true
```

### Parameters overwrite

On each api call, you can overwrite the api key or the test parameter, i.e.

```ruby
   Eligible::Demographic.get(params.merge({:api_key => 'NEW_KEY', :test => false})
```

### Response Format

By default, all the responses came in JSON, but you can request raw access to X12 by adding is as a parameter on the api call.

```ruby
   Eligible::Demographic.get(params.merge({:format => "x12"}))
```

### Api Call Results

On all the results, you can check for errors in *result.error*, you can get get the raw json format in a has by using *result.to_hash*.

```ruby
demographic = Eligible::Demographic.get(params)
demographic.error
demographic.to_hash
```

## Coverage

### Reference

[https://eligibleapi.com/rest-api-v1-1/coverage-all#apiCoverageInfo](https://eligibleapi.com/rest-api-v1-1/coverage-all#apiCoverageInfo)

### Retrieve eligibility & benefit information

```ruby
params = {
  :service_type => "33",
  :network => "OUT",
  :payer_id   => "000001",
  :provider_last_name => "Last",
  :provider_first_name => "First",
  :provider_npi => "12345678",
  :member_id => "12345678",
  :member_last_name => "Austen",
  :member_first_name => "Jane",
  :member_dob => "1955-12-14"
}

coverage = Eligible::Coverage.get(params)
coverage.to_hash # returns all coverage info for the request
coverage.error   # return error, if any
```

## Demographic

### Reference

[https://eligibleapi.com/rest-api-v1-1/demographic-all#apiDemographics](https://eligibleapi.com/rest-api-v1-1/demographic-all#apiDemographics)

### Fetch demographics for a patient

```ruby
params = {
  :payer_name => "Aetna",
  :payer_id   => "000001",
  :provider_last_name => "Last",
  :provider_first_name => "First",
  :provider_npi => "12345678",
  :member_id => "12345678",
  :member_last_name => "Austen",
  :member_first_name => "Jane",
  :member_dob => "1955-12-14"
}

demographic = Eligible::Demographic.get(params)
demographic.to_hash # returns all coverage info for the request
demographic.error   # return error, if any
```

## Medicare

### Reference

[https://eligibleapi.com/rest-api-v1-1/medicare#apiMedicare](https://eligibleapi.com/rest-api-v1-1/medicare#apiMedicare)

### Retrieve eligibility & benefit information from CMS Medicare for a patient.

```ruby
params = {
  :payer_id   => "000001",
  :provider_last_name => "Last",
  :provider_first_name => "First",
  :provider_npi => "12345678",
  :member_id => "12345678",
  :member_last_name => "Austen",
  :member_first_name => "Jane",
  :member_dob => "1955-12-14"
}
medicare = Eligible::Medicare.get(params)
medicare.to_hash # returns all coverage info for the request
medicare.error   # return error, if any

```

## Batch API

### Reference

[https://github.com/EligibleAPI/tools/wiki/Batch-Api](https://github.com/EligibleAPI/tools/wiki/Batch-Api)

Its important to notice that all the batch api calls, will notify the results by a webhook.

You can setup a webhook in your [Dashboard](https://www.eligibleapi.com/dashboard/webhooks).

All the batch api calls, returns a *reference_id* value and the *number_of_items* submitted.

### Coverage Batch API

```ruby
params = {
    "api_key"=>"81ef98e5-4584-19fb-0d8c-6e987b95d695",
    "parameters"=>[
        {
            "id"=>1,
            "payer_name"=>"UnitedHealthCare",
            "payer_id"=>"00112",
            "service_provider_npi"=>"12341234",
            "subscriber_id"=>"98769876",
            "subscriber_first_name"=>"Jane",
            "subscriber_last_name"=>"Austen",
            "service_provider_last_name"=>"Gaurav",
            "service_provider_first_name"=>"Gupta",
            "subscriber_dob"=>"1947-10-07"
        },
        {
            "id"=>2,
            "payer_name"=>"UnitedHealthCare",
            "payer_id"=>"00112",
            "service_provider_npi"=>"67676767",
            "subscriber_id"=>"98989898",
            "subscriber_first_name"=>"Gaurav",
            "subscriber_last_name"=>"Gupta",
            "service_provider_last_name"=>"Jane",
            "service_provider_first_name"=>"Austen",
            "subscriber_dob"=>"1947-08-15"
        }
    ]
}

result = Eligible::Coverage.batch_post(params)
result.to_hash # returns the api call results
result.error   # return error, if any
```

### Demographic Batch API

```ruby
params = {
    "parameters"=>[
        {
            "id"=>1,
            "payer_name"=>"UnitedHealthCare",
            "payer_id"=>"00112",
            "service_provider_npi"=>"12341234",
            "subscriber_id"=>"98769876",
            "subscriber_first_name"=>"Jane",
            "subscriber_last_name"=>"Austen",
            "service_provider_last_name"=>"Gaurav",
            "service_provider_first_name"=>"Gupta",
            "subscriber_dob"=>"1947-10-07"
        },
        {
            "id"=>2,
            "payer_name"=>"UnitedHealthCare",
            "payer_id"=>"00112",
            "service_provider_npi"=>"67676767",
            "subscriber_id"=>"98989898",
            "subscriber_first_name"=>"Gaurav",
            "subscriber_last_name"=>"Gupta",
            "service_provider_last_name"=>"Jane",
            "service_provider_first_name"=>"Austen",
            "subscriber_dob"=>"1947-08-15"
        }
    ]
}
result = Eligible::Demographic.batch_post(params)
result.to_hash # returns the api call results
result.error   # return error, if any
```

### Medicare Batch API

```ruby
params = {
    "parameters"=>[
        {
            "id"=>1,
            "service_provider_npi"=>"12341234",
            "subscriber_id"=>"98769876",
            "subscriber_first_name"=>"Jane",
            "subscriber_last_name"=>"Austen",
            "service_provider_last_name"=>"Gaurav",
            "service_provider_first_name"=>"Gupta",
            "subscriber_dob"=>"1947-10-07"
        },
        {
            "id"=>2,
            "service_provider_npi"=>"67676767",
            "subscriber_id"=>"98989898",
            "subscriber_first_name"=>"Gaurav",
            "subscriber_last_name"=>"Gupta",
            "service_provider_last_name"=>"Jane",
            "service_provider_first_name"=>"Austen",
            "subscriber_dob"=>"1947-08-15"
        }
    ]
}

Eligible::Coverage.batch_medicare_post params
result.to_hash # returns the api call results
result.error   # return error, if any
```

## Enrollment

### Reference

[https://github.com/EligibleAPI/tools/wiki/Enrollments](https://github.com/EligibleAPI/tools/wiki/Enrollments)

Its important to notice than an Enrollment Request can have multiple Enrollment NPIs, and that the API has been designed
in a way that you can repeat the enrollment for a NPI multiple times across different Enrollment request.

### Create an Enrollment Request

```ruby
params = {
  "service_provider_list" => [
      {
        "facility_name" => "Quality",
        "provider_name" => "Jane Austen",
               "tax_id" => "12345678",
              "address" => "125 Snow Shoe Road",
                 "city" => "Sacramento",
                "state" => "CA",
                  "zip" => "94107",
                 "ptan" => "54321",
                  "npi" => "987654321"
      },
      {
        "facility_name" => "Aetna",
        "provider_name" => "Jack Austen",
               "tax_id" => "12345678",
              "address" => "985 Snow Shoe Road",
                 "city" => "Menlo Park",
                "state" => "CA",
                  "zip" => "94107",
                 "ptan" => "54321",
                  "npi" => "987654321"
      }
    ],
    "payer_ids" => [
      "00431",
      "00282"
    ]
}
result = Eligible::Enrollment.post(params)
result.to_hash # returns the api call results
result.error   # return error, if any

```

### Retrieve an Enrollment Request

```ruby
params = { :enrollment_request_id => 123 }
enrollment = Eligible::Enrollment.get(params)
enrollment.to_ash # return the api call results
enrollment.error  # return error, if any
enrollment.enrollment_npis # quick access to the enrollment npis within the enrollment request object

params = { :npis => %w(123 456 789).join(',') }
enrollment = Eligible::Enrollment.get(params)

```


## Claims

### Reference

[https://github.com/EligibleAPI/tools/wiki/Claims](https://github.com/EligibleAPI/tools/wiki/Claims)

### Create Claim object

```ruby
params = {
    "receiver" => {
        "name" => "AETNA",
        "id" => "60054"
    },
    "billing_provider" => {
        "taxonomy_code" => "332B00000X",
        "practice_name" => "Jane Austen Practice",
        "npi" => "1922222222",
        "address" => {
            "street_line_1" => "419 Fulton",
            "street_line_2" => "",
            "city" => "San Francisco",
            "state" => "CA",
            "zip" => "94102"
        },
        "tin" => "43291023"
    },
    "subscriber" => {
        "last_name" => "Franklin",
        "first_name" => "Benjamin",
        "member_id" => "12312312",
        "group_id" => "455716",
        "group_name" => "",
        "dob" => "1734-05-04",
        "gender" => "M",
        "address" => {
            "street_line_1" => "435 Sugar Lane",
            "street_line_2" => "",
            "city" => "Sweet",
            "state" => "OH",
            "zip" => "436233127"
        }
    },
    "payer" => {
        "name" => "AETNA",
        "id" => "60054",
        "address" => {
            "street_line_1" => "Po Box 981106",
            "street_line_2" => "",
            "city" => "El Paso",
            "state" => "TX",
            "zip" => "799981222"
        }
    },
    "claim" => {
        "total_charge_amount" => "275",
        "claim_frequency" => "1",
        "patient_signature_on_file" => "Y",
        "provider_plan_participation" => "A",
        "direct_payment_authorized" => "Y",
        "release_of_information" => "I",
        "service_lines" => [
            {
                "line_number" => "1",
                "service_start" => "2013-03-07",
                "service_end" => "2013-03-07",
                "place_of_service" => "11",
                "charge_amount" => "275",
                "product_service" => "99213",
                "qualifier" => "HC",
                "diagnosis_1" => "32723"
            }
        ]
    }
}

result = Eligible::Claim.post(params)
enrollment.to_ash # return the api call results
enrollment.error  # return error, if any
```

### Retrieve all Claim objects/acknowledgments

```ruby
claims = Eligible::Claim.all # returns acknowlegdement information for all claims that have been submitted with the API key
```

### Retrieve individual Claim object/acknowledgment

```ruby
params = { 
  :reference_id => "12345"
}

claim = Eligible::Claim.get(params) # returns acknoweldement information on an individual claim identified by its reference_id
```

## Payment Status

### Reference

[https://eligibleapi.com/rest-api-v1-1/beta/payment-status#apiPaymentStatus](https://eligibleapi.com/rest-api-v1-1/beta/payment-status#apiPaymentStatus)

### Retrieve  Payment status

```ruby
params = { :reference_id => "89898989" }

Eligible::Payment.get(params) # returns status information on an individual payment identified by its reference_id
```

## X12

### Reference

[https://github.com/EligibleAPI/tools/wiki/X12](https://github.com/EligibleAPI/tools/wiki/X12)

### X12 post

```ruby
params = { :x12 => "ISA*00*          *00*          *ZZ*SENDERID       *ZZ*ELIGIB         *130610*0409*^*00501*100000001*0*T*:~GS*HS*SENDERID*ELIGIB*20130610*0409*1*X*005010X279A1~ST*270*0001*005010X279A1~BHT*0022*13*137083739083716126837*20130610*0409~HL*1**20*1~NM1*PR*2*UnitedHealthCare*****PI*112~HL*2*1*21*1~NM1*1P*1*AUSTEN*JANE****XX*1222494919~HL*3*2*22*0~TRN*1*1*1453915417~NM1*IL*1*FRANKLIN*BENJAMIN****MI*23412342~DMG*D8*17371207~DTP*291*D8*20130610~EQ*30~SE*13*0001~GE*1*1~IEA*1*100000001~" }

result = Eligible::X12.post(params)
```

## Tickets

### Reference

[https://github.com/EligibleAPI/tools/wiki/Tickets](https://github.com/EligibleAPI/tools/wiki/Tickets)

### Create a ticket



##Tickets
possible params
`https://github.com/EligibleAPI/tools/wiki/Tickets`

###Create a ticket
```ruby

  params = { :priority => 'normal',
             :title => 'TITLE',
             :notification_email => 'admin@eligibleapi.com',
             :body => 'Your comment'}

 Eligible::Ticket.create params
```
###Comments
```ruby
  params = { :reference_id => "89898989",
             :body => 'Your comment'}
  Eligible::Ticket.comments params
```

###Retrieve
One ticket
```ruby
 params = { :reference_id => "89898989" }
 Eligible::Ticket.get params
```
All tickets
```ruby
  Eligible::Ticket.all
```

###Delete
```ruby
  params = { :reference_id => "89898989" }
  Eligible::Ticket.delete params
```
###Update
```ruby
  params = { :reference_id => "89898989",
             :priority => 'normal',
             :title => 'TITLE',
             :notification_email => 'admin@eligibleapi.com',
             :body => 'Your comment'}
  Eligible::Ticket.update params
```

### Tests

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

#### 2.5
- Refactoring Code
- More test cases
- Removed legacy endpoint for *plans*, *coverage* should be used instead.
- List of contributors and documentation updated.
- Gemfile updated, dependencies updated as well.
- Removed json gem in favor of multi_json

#### 2.4
- New endpoint for Tickets

#### 2.3
- New endpoint for Batch

#### 2.2
- New endpoint for x12 POST

#### 2.1 
- New endpoint for payment status

#### 2.0

- Additional endpoints for claims, enrollments, and coverage

#### 1.1

- Additional endpoints for service/general and service/list
- Support x12 format in params

#### 1.0

- Initial release
