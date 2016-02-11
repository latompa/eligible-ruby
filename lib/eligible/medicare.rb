module Eligible
  class Medicare < CoverageResource
    def self.get(params, api_key = nil)
      @url = '/medicare/coverage.json'
      super(params, api_key)
    end

    def self.batch_post(params, api_key = nil)
      @url = '/medicare/coverage/batch.json'
      super(params, api_key)
    end
  end
end
