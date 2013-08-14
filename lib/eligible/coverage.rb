module Eligible

  class Coverage < APIResource

    def self.get(params, api_key=nil)
      response, api_key = Eligible.request(:get, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)      
    end

    def all
      error ? nil : to_hash
    end



    def self.batch_post(params, api_key=nil)
      #https://gds.eligibleapi.com/v1.1/coverage/all/batch.json
      response, api_key = Eligible.request(:post, '/coverage/all/batch.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def self.batch_medicare_post(params, api_key=nil)
      response, api_key = Eligible.request(:post, '/medicare/coverage/batch.json', api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

  end

end