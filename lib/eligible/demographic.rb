module Eligible
  class Demographic < APIResource
    COMMON_ATTRIBUTES = [:timestamp, :eligible_id, :mapping_version]
    ZIP_ATTRIBUTES = [:zip]
    EMPLOYER_ATTRIBUTES = [:group_id, :group_name]
    ADDRESS_ATTRIBUTES = [:address]
    DOB_ATTRIBUTES = [:dob]

    def all
      error ? nil : to_hash
    end

    def zip
      keys = COMMON_ATTRIBUTES
      h = to_hash.select { |k, v| keys.include?(k) }
      h[:zip] = to_hash[:address][:zip]
      error ? nil : h
    end

    def employer
      keys = COMMON_ATTRIBUTES + EMPLOYER_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def address
      keys = COMMON_ATTRIBUTES + ADDRESS_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def dob
      keys = COMMON_ATTRIBUTES + DOB_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end
  end
end