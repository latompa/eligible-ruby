module Eligible
  class Claim < APIResource
    def status
      error ? nil : to_hash
    end
  end
end