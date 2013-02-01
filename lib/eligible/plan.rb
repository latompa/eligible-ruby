module Eligible
  class Plan < APIResource

    def self.all(params, api_key=nil)
      response, api_key = Eligible.request(:get, url, api_key, params)
      # refresh_from(response, api_key)
      # self
      response
    end
  end
end