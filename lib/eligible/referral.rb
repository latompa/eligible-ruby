module Eligible
  class Referral < PreauthResource
    def self.inquiry_uri
      return '/referral/inquiry.json'
    end

    def self.create_uri
      return '/referral/create.json'
    end
  end
end
