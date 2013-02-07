module Eligible
  COMMON_ATTRIBUTES = [:timestamp, :eligible_id, :mapping_version, :primary_insurance, :additional_insurance]
  STATUS_ATTRIBUTES = [:type, :coverage_status]
  BALANCE_ATTRIBUTES = [:balance, :comments]
  STOP_LOSS_ATTRIBUTES = [:stop_loss_in_network, :stop_loss_out_network]

  class Plan < APIResource
    def self.get(params, api_key=nil)
      response, api_key = Eligible.request(:get, url, api_key, params)
      Util.convert_to_eligible_object(response, api_key)
    end

    def all
      error ? nil : to_hash
    end

    def status
      keys = COMMON_ATTRIBUTES + STATUS_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def deductible
      keys = COMMON_ATTRIBUTES + STATUS_ATTRIBUTES + [:deductible_in_network, :deductible_out_network]
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def dates
      keys = COMMON_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def balance
      keys = COMMON_ATTRIBUTES + BALANCE_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end

    def stop_loss
      keys = COMMON_ATTRIBUTES + STOP_LOSS_ATTRIBUTES
      error ? nil : to_hash.select { |k, v| keys.include?(k) }
    end
  end
end