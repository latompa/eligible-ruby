module Eligible
  module Util

    def self.key?(params, key)
      [key.to_sym, key.to_s].any? { |k| params.key?(k) }
    end

    def self.value(params, key)
      params[key.to_sym] || params[key.to_s]
    end

    def self.convert_to_eligible_object(resp, api_key)
      case resp
      when Array
        if resp[0] && resp[0][:enrollment_npi]
          Enrollment.construct_from({ enrollments: resp }, api_key)
        else
          resp.map { |i| convert_to_eligible_object(i, api_key) }
        end
      when Hash
        if resp[:enrollment_npi]
          klass = Enrollment
        elsif resp[:demographics]
          klass = Coverage
        elsif resp[:subscriber] && resp[:dependent]
          klass = Demographic
        end
        klass ||= EligibleObject
        klass.construct_from(resp, api_key)
      else
        resp
      end
    end

    # Converts a key into a symbol if it is possible, returns the key if it is not
    def self.symbolize_name(key)
      return key unless key.respond_to?(:to_sym)
      return key.to_sym
    end

    def self.symbolize_names(object)
      case object
      when Hash
        {}.tap do |new_hash|
          object.each do |key, value|
            key = symbolize_name(key)
            new_hash[key] = symbolize_names(value)
          end
        end
      when Array
        object.map { |value| symbolize_names(value) }
      else
        object
      end
    end

    def self.url_encode(key)
      URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def self.flatten_params(params, parent_key = nil)
      result = []
      params.each do |key, value|
        calculated_key = parent_key ? "#{parent_key}[#{url_encode(key)}]" : url_encode(key)
        if value.is_a?(Hash)
          result += flatten_params(value, calculated_key)
        elsif value.is_a?(Array)
          result += flatten_params_array(value, calculated_key)
        else
          result << [calculated_key, value]
        end
      end
      result
    end

    def self.flatten_params_array(value, calculated_key)
      result = []
      value.each_with_index do |elem, index|
        if elem.is_a?(Hash)
          result += flatten_params(elem, calculated_key)
        elsif elem.is_a?(Array)
          result += flatten_params_array(elem, calculated_key)
        else
          result << ["#{calculated_key}[#{index}]", elem]
        end
      end
      result
    end
  end
end
