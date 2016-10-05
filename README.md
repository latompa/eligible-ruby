# Eligible

[![Circle CI](https://circleci.com/gh/eligible/eligible-ruby.svg?style=svg)](https://circleci.com/gh/eligible/eligible-ruby) [![Code Climate](https://codeclimate.com/github/eligible/eligible-ruby/badges/gpa.svg)](https://codeclimate.com/github/eligible/eligible-ruby)

Ruby bindings for the [Eligible API](https://eligible.com/rest)

## Installation

Add this line to your application's Gemfile:

    gem 'eligible'

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install eligible

## Usage

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

On each api call, you can overwrite the api key or the test parameter:

```ruby
Eligible::Coverage.get({:api_key => 'NEW_KEY', :test => false})
```

### Response Format

By default, all responses are in JSON, but you can request raw
access to X12 by adding is as a parameter on the api call:

```ruby
Eligible::Coverage.get({:format => "x12"})
```

# Important notes

## Payer List for Eligibility

the parameter `payer_id`, required for most of the api calls, is
provided by Eligible from its website, in xml and json format, which
you can embed into your applications.

[https://eligible.com/resources/payers/eligibility.xml](https://eligible.com/resources/payers/eligibility.xml)

[https://eligible.com/resources/payers/eligibility.json](https://eligible.com/resources/payers/eligibility.json)

## Payer List for Claims

the parameter `payer_id`, required for claims, is provided by Eligible
from its website, in xml and json format, which you can embed into
your applications.

## Medical

[https://eligible.com/resources/payers/claims/medical.xml](https://eligible.com/resources/payers/claims/medical.xml)

[https://eligible.com/resources/payers/claims/medical.json](https://eligible.com/resources/payers/claims/medical.json)

## Institutional

[https://eligible.com/resources/payers/claims/institutional.xml](https://eligible.com/resources/payers/claims/institutional.xml)

[https://eligible.com/resources/payers/claims/institutional.json](https://eligible.com/resources/payers/claims/institutional.json)

## Dental

[https://eligible.com/resources/payers/claims/dental.xml](https://eligible.com/resources/payers/claims/dental.xml)

[https://eligible.com/resources/payers/claims/dental.json](https://eligible.com/resources/payers/claims/dental.json)

## Service Type Codes

the parameter `service_type`, required on the api calls, is provided
by Eligible from its website, in xml and json format, which you can
embed into your applications.

[https://eligible.com/resources/service-codes.xml](https://eligible.com/resources/service-codes.xml)  
[https://eligible.com/resources/service-codes.json](ttps://eligible.com/resources/service-codes.json)

## Place of Service

[https://eligible.com/resources/place_of_service.json](https://eligible.com/resources/place_of_service.json)

## Health Care Provider Taxonomy

[https://eligible.com/resources/health-care-provider-taxonomy-code-set.json](https://eligible.com/resources/health-care-provider-taxonomy-code-set.json)

### Api Call Results

On all results you can check for errors in `result.error`. The raw
json format is available by using `result.to_hash`.

```ruby
coverage = Eligible::Coverage.get(params)
coverage.error
coverage.to_hash
```

## Coverage

### Reference

[https://reference.eligible.com/#coverage](https://reference.eligible.com/#coverage)

### Retrieve eligibility and benefit information

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

## Cost Estimate

### Reference
[https://eligible.com/reference/cost-estimates](https://eligible.com/reference/cost-estimates)

### Retrieve cost estimate information

```ruby
params = {
  service_type: '98',
  network: 'IN',
  payer_id: '00001',
  provider_npi: '1234567893',
  member_id: 'COST_ESTIMATE_001',
  member_dob: '1886-01-01',
  provider_price: '200',
  level: 'individual'
}

cost_estimate = Eligible::Coverage.cost_estimate(params)
cost_estimate.to_hash # returns all coverage info along with cost estimate
```

## Medicare

### Reference

[https://reference.eligible.com/#medicare](https://reference.eligible.com/#medicare)

### Retrieve eligibility and benefit information from CMS Medicare for a patient.

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

## Enrollment

Enrollment requests can have multiple enrollment NPIs. You can repeat
the enrollment for a NPI multiple times across different enrollment
requests.

### Reference
[https://reference.eligible.com/#enrollment-introduction](https://reference.eligible.com/#enrollment-introduction)

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
enrollment.to_hash # return the api call results
enrollment.error  # return error, if any
enrollment.enrollment_npis # quick access to the enrollment npis within the enrollment request object

params = { :npis => %w(123 456 789).join(',') }
enrollment = Eligible::Enrollment.get(params)
```

## Claims

### Reference

[https://reference.eligible.com/#create-a-claim](https://reference.eligible.com/#create-a-claim)

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
enrollment.to_hash # return the api call results
enrollment.error  # return error, if any
```

### Retrieve all Claim objects/acknowledgments

```ruby
claims = Eligible::Claim.all # returns acknowledgment information for all claims that have been submitted with the API key
```

### Retrieve individual Claim object/acknowledgment

```ruby
params = {
  :reference_id => "12345"
}

claim = Eligible::Claim.get(params) # returns acknowledgment information on an individual claim identified by its reference_id
```

## Payment Status

### Reference

[https://reference.eligible.com/#payment-status](https://reference.eligible.com/#payment-status)

### Retrieve  Payment status

```ruby
params = { :payer_id => '00001',
           :provider_tax_id => '4373208923',
           :provider_npi => '1234567890',
           :provider_first_name => 'Thomas',
           :provider_first_name => 'Thomas',
           :member_id => '123',
           :member_first_name => 'Benjamin',
           :member_last_name => 'Franklin',
           :member_dob => '01-01-1980',
           :charge_amount => '100.00',
           :start_date => '2013-03-25',
           :end_date => '2013-03-25' }

result = Eligible::Payment.get(params)
result.to_hash   # return the api call results
result.error     # return error, if any
```

## X12

### X12 post

```ruby
params = { :x12 => "ISA*00*          *00*          *ZZ*SENDERID       *ZZ*ELIGIB         *130610*0409*^*00501*100000001*0*T*:~GS*HS*SENDERID*ELIGIB*20130610*0409*1*X*005010X279A1~ST*270*0001*005010X279A1~BHT*0022*13*137083739083716126837*20130610*0409~HL*1**20*1~NM1*PR*2*UnitedHealthCare*****PI*112~HL*2*1*21*1~NM1*1P*1*AUSTEN*JANE****XX*1222494919~HL*3*2*22*0~TRN*1*1*1453915417~NM1*IL*1*FRANKLIN*BENJAMIN****MI*23412342~DMG*D8*17371207~DTP*291*D8*20130610~EQ*30~SE*13*0001~GE*1*1~IEA*1*100000001~" }

result = Eligible::X12.post(params)
```

## Tickets

### Reference

[https://reference.eligible.com/#create-a-ticket](https://reference.eligible.com/#create-a-ticket)

### Create a ticket

```ruby
params = {:priority => 'normal',
          :title => 'TITLE',
          :notification_email => 'admin@eligible.com',
          :body => 'Your comment'}
result = Eligible::Ticket.create params
result.to_hash # return the api call results
enrollment.error  # return error, if any
```

### Get a ticket

```ruby
ticket = Eligible::Ticket.get(:id => 1)
ticket.to_hash # return the api call result
ticket.error   # return error, if any
```

### Update a ticket

```ruby
params = { :id => 1,
           :priority => 'normal',
           :title => 'TITLE',
           :notification_email => 'your_email@test.com',
           :body => 'Your comment'}
result = Eligible::Ticket.update(params)
result.to_hash # return the api call results
enrollment.error  # return error, if any
```

### Get comments for a ticket

```ruby
comments = Eligible::Ticket.get(:id => 1)
comments.to_hash # return the api call result
comments.error   # return error, if any

```

### Delete a ticket
```ruby
result = Eligible::Ticket.delete(:id => 1)
comments.to_hash # return the api call result
comments.error   # return error, if any
```

### Get all tickets

```ruby
Eligible::Ticket.all
```

## Customer

### Reference

[https://reference.eligible.com/#customers-introduction](https://reference.eligible.com/#customers-introduction)

### Create a customer

```ruby
customer_params = { customer: { name: "ABC company", 
                                site_name: "ABC site name"
                              }
                  }
customer_response = Eligible::Customer.post(customer_params)
customer_response.to_json
```

### Get a customer

```ruby
customer_params = { customer_id: "123" }
customer_response = Eligible::Customer.get(customer_params)
customer_response.to_json
```

### Update a customer

```ruby
customer_params = { customer_id: "123",
                    customer: { site_name: "XYZ site name" }
                  }
customer_response = Eligible::Customer.update(customer_params)
customer_response.to_json
```

### Get all customers

```ruby
customer_params = {}
customer_response = Eligible::Customer.all(customer_params)
customer_response.to_json
```

## Received Pdf

### Reference

[https://reference.eligible.com/#view-received-pdf](https://reference.eligible.com/#view-received-pdf)

### Get received pdf

```ruby
params = { enrollment_npi_id: '123' }
response = Eligible::ReceivedPdf.get(params)
response.to_hash
```

### Download received pdf
By default, it downloads to /tmp/received_pdf.pdf
```ruby
params = { enrollment_npi_id: '123', filename: 'file_path_where_to_download' }
Eligible::ReceivedPdf.download(params)
```

## Original Signature Pdf

### Reference

[https://reference.eligible.com/#create-original-signature-pdf](https://reference.eligible.com/#create-original-signature-pdf)

### Get original signature pdf

```ruby
params = { enrollment_npi_id: '123' }
response = Eligible::OriginalSignaturePdf.get(params)
response.to_hash
```

### Create original signature pdf

```ruby
params = { enrollment_npi_id: '123' }
params[:file] = File.new('path_to_file')
response = Eligible::OriginalSignaturePdf.post(params)
response.to_hash
```

### Update original signature pdf

```ruby
params = { enrollment_npi_id: '123' }
params[:file] = File.new('path_to_new_file')
response = Eligible::OriginalSignaturePdf.update(params)
response.to_hash
```

### Download original signature pdf
By default, it downloads to /tmp/original_signature_pdf.pdf
```ruby
params = { enrollment_npi_id: '123', filename: 'file_path_where_to_download' }
Eligible::OriginalSignaturePdf.download(params)
```

### Delete original signature pdf

```ruby
params = { enrollment_npi_id: '123' }
response = Eligible::OriginalSignaturePdf.delete(params)
response.to_hash
```

## Payer

### Reference

[https://reference.eligible.com/#introduction](https://reference.eligible.com/#introduction)

### List all the payers

```ruby
response = Eligible::Payer.list({})
response.collect { |payer| payer.to_hash }
```

### View a single payer

```ruby
params = { payer_id: '12345' }
response = Eligible::Payer.get(params)
response.to_hash
```

### Search options for a payer

```ruby
params = { payer_id: '12345' }
response = Eligible::Payer.search_options(params)
response.to_hash
``` 

### Search options for all payers

```ruby
response = Eligible::Payer.search_options({})
response.collect { |payer| payer.to_hash }
```

## Precertification

### Reference

[https://reference.eligible.com/#precertification](https://reference.eligible.com/#precertification)

### Inquiry

```ruby
params = { provider_npi: '1234567893',
           member_id: 'ABCDEF',
           member_dob: '2016-03-04'
         }
response = Eligible::Precert.inquiry(params)
response.to_hash
```

### Create

```ruby
params = { 'requester' => { 'information' => 'test' },
           'subscriber' => { 'last_name' => 'XYZ',
                             'first_name' => 'AVC',
                             'id' => '231213'
                           },
           'event' => { 'provider' => 'information' },
           'services' => [{ 'service' => 'test' }]
         }
response = Eligible::Precert.create(params)
response.to_hash
```

## Referral

### Inquiry

```ruby
params = { provider_npi: '1234567893',
           member_id: 'ABCDEF',
           member_dob: '2016-03-04'
         }
response = Eligible::Referral.inquiry(params)
response.to_hash
```

### Create

```ruby
params = { 'requester' => { 'information' => 'test' },
           'subscriber' => { 'last_name' => 'XYZ',
                             'first_name' => 'AVC',
                             'id' => '231213'
                           },
           'event' => { 'provider' => 'information' },
           'services' => [{ 'service' => 'test' }]
         }
response = Eligible::Referral.create(params)
response.to_hash
```

## Errors

This is the list of errors thrown from the eligible ruby gem.

1. Eligible::EligibleError - Base class for the customized errors raised from Eligible gem.
2. Eligible::APIError - Raised when there is some invalid response from the api call. Raised for error codes other than 400, 401 and 404.
3. Eligible::APIConnectionError - Raised when there is some network issue like socket error, not able to connect to Eligible etc.
4. Eligible::InvalidRequestError - Raised when error code is 400 or 404.
5. Eligible::AuthenticationError - Raised when authentication fails. Mostly due to wrong api key.
6. NotImplementedError - Raised when the functionality you are trying to use doesn't exist.
7. ArgumentError - Raised when all the required params are not provided.


## Contributing

Running `rake` will run the test suite along with rubocop as a basic
style assessment. If you are going to submit a pull request, please
verify that all tests pass and there are no rubocop errors. Please add
additional tests for any features or fixes provided.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run tests (see above)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
