module Eligible
  class Plan < APIResource

    def self.all(params, api_key=nil)
      Eligible.request(:get, url, api_key, params)
    end
  end
end