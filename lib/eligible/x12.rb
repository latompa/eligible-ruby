module Eligible
  class X12 < APIResource

    def self.post(params, api_key=nil)
      #response, api_key = Eligible.request(:post, "/x12", Eligible.api_key, params)
      #Util.convert_to_eligible_object(response, api_key)
      require 'net/http'
      require 'net/https'
      require 'uri'
      uri = URI.parse("https://gds.eligibleapi.com")
      x12 = params

      post_args = "x12=#{x12}&api_key=#{Eligible.api_key}"
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      path = "/v1.1/x12"
      response = http.post(path, post_args)
      Util.convert_to_eligible_object(response, Eligible.api_key)
    end
  end
end