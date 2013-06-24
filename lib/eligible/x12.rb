module Eligible
  class X12 < APIResource

    def self.post(params, api_key=nil)
      require 'net/http'
      require 'net/https'
      require 'uri'
      uri = URI.parse("https://gds.eligibleapi.com")

      post_args = "x12=#{params}&api_key=#{Eligible.api_key}&test=#{Eligible.test}"
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      path = "/v1.1/x12"
      response = http.post(path, post_args)
      Util.convert_to_eligible_object(response, Eligible.api_key)
    end
  end
end