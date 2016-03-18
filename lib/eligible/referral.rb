module Eligible
  class Referral < PreauthResource
    def self.get_uri
      return '/referral/inquiry.json'
    end

    def self.post_uri
      return '/referral/create.json'
    end
  end
end
