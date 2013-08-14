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
    Eligible.api_key = 'YOUR_KEY'
### Test
```ruby
Eligible.test = true
 ```
Include `{ :test => "true" }` in the params for sandbox access.
### Format

Include `{ :format => "X12" }` in the params hash to get back the raw X12 response.


### Retrieve Demographic object and query it

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
demographic.all # returns all fields for the demographic, per demographic/all
```



##Batch post Demographic
**POST** `https://gds.eligibleapi.com/v1.1/demographic/all/batch.json`

```ruby

Eligible.test = true
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
Eligible::Demographic.batch_post params
# return
Eligible::EligibleObject:0x000000058914a8 @api_key="XXX",
                                          @values={:reference_id=>"1ea06414-2132-52e1-1580-aea92f37720b",
                                                   :number_of_items=>2},
                                          @unsaved_values=#<Set: {}>,
                                          @transient_values=#<Set: {}>>
```

### Retrieve Coverage object

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
coverage.all # returns all coverage info for the request
```
##Batch post Coverage
**POST** `https://gds.eligibleapi.com/v1.1/coverage/all/batch.json`

```ruby
Eligible.test = true
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

Eligible::Coverage.batch_post params
#Return:
Eligible::EligibleObject:0x000000059a11b8 @api_key="XXX",
                                          @values={:reference_id=>"1ea06414-2132-52e1-1580-aea92f37720b",
                                                    :number_of_items=>2},
                                          @unsaved_values=#<Set: {}>,
                                          @transient_values=#<Set: {}>>

```
##Batch post Medicare
**POST** `https://gds.eligibleapi.com/v1.1/medicare/coverage/batch.json`

```ruby
Eligible.test = true
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
#Return:
 Eligible::EligibleObject:0x00000004db0188 @api_key="72cbca2e-1da7-b030-d2e6-a05cbae11c1b",
                                           @values={:reference_id=>"1ea06414-2132-52e1-1580-aea92f37720b",
                                                    :number_of_items=>2},
                                           @unsaved_values=#<Set: {}>,
                                           @transient_values=#<Set: {}>>
```





### Post Enrollment object

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

Eligible::Enrollment.post(params)
```

### Retrieve Enrollment object

```ruby
params = { "enrollment_request_id" => "123" }

enrollment = Eligible::Enrollment.get(params)

enrollment.enrollment_npis # returns a list of enroll the provider(s)
```

### Post Claim object

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

Eligible::Claim.post(params)
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

### Retrieve  Payment status

```ruby
params = { :reference_id => "89898989" }

Eligible::Payment.get(params) # returns status information on an individual payment identified by its reference_id
```



### X12 post

```ruby
param = "ISA*00*          *00*          *ZZ*SENDERID       *ZZ*ELIGIB         *130610*0409*^*00501*100000001*0*T*:~GS*HS*SENDERID*ELIGIB*20130610*0409*1*X*005010X279A1~ST*270*0001*005010X279A1~BHT*0022*13*137083739083716126837*20130610*0409~HL*1**20*1~NM1*PR*2*UnitedHealthCare*****PI*112~HL*2*1*21*1~NM1*1P*1*AUSTEN*JANE****XX*1222494919~HL*3*2*22*0~TRN*1*1*1453915417~NM1*IL*1*FRANKLIN*BENJAMIN****MI*23412342~DMG*D8*17371207~DTP*291*D8*20130610~EQ*30~SE*13*0001~GE*1*1~IEA*1*100000001~"

Eligible::X12.post param # <Net::HTTPOK 200 OK readbody=true>
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
