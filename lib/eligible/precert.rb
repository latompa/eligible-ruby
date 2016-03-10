module Eligible
  class Precert < PreauthResource
    def self.inquiry_uri
      return '/precert/inquiry.json'
    end

    def self.create_uri
      return '/precert/create.json'
    end
  end
end
