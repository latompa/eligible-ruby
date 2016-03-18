module Eligible
  class PreauthResource < CoverageResource
    def self.inquiry(params, api_key = nil)
      get(params, api_key)
    end

    def self.create(params, api_key = nil)
      post(params, api_key)
    end
  end
end
