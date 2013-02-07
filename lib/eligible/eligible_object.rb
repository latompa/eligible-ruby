module Eligible

  class EligibleObject
    include Enumerable

    attr_accessor :api_key
    attr_accessor :eligible_id
    @@permanent_attributes = Set.new([:api_key, :error, :balance, :address, :dob])

    # The default :id method is deprecated and isn't useful to us
    if method_defined?(:id)
      undef :id
    end

    def initialize(id=nil, api_key=nil)
      @api_key = api_key
      @values = {}
      # This really belongs in APIResource, but not putting it there allows us
      # to have a unified inspect method
      @unsaved_values = Set.new
      @transient_values = Set.new
      self.eligible_id = id if id
    end

    def self.construct_from(values, api_key=nil)
      obj = self.new(values[:eligible_id], api_key)
      obj.refresh_from(values, api_key)
      obj
    end

    def refresh_from(values, api_key, partial=false)
      @api_key = api_key

      removed = partial ? Set.new : Set.new(@values.keys - values.keys)
      added = Set.new(values.keys - @values.keys)
      # Wipe old state before setting new.  This is useful for e.g. updating a
      # customer, where there is no persistent card parameter.  Mark those values
      # which don't persist as transient

      instance_eval do
        remove_accessors(removed)
        add_accessors(added)
      end
      removed.each do |k|
        @values.delete(k)
        @transient_values.add(k)
        @unsaved_values.delete(k)
      end
      values.each do |k, v|
        @values[k] = v#Util.convert_to_eligible_object(v, api_key)
        @transient_values.delete(k)
        @unsaved_values.delete(k)
      end
    end

    def [](k)
      k = k.to_sym if k.kind_of?(String)
      @values[k]
    end

    def []=(k, v)
      send(:"#{k}=", v)
    end

    def keys
      @values.keys
    end

    def values
      @values.values
    end

    def to_json(*a)
      Eligible::JSON.dump(@values)
    end

    def to_hash
      @values
    end

    def each(&blk)
      @values.each(&blk)
    end

    def error
      keys.include?(:error) ? @values[:error] : nil
    end

    protected

    def metaclass
      class << self; self; end
    end    

    def remove_accessors(keys)
      metaclass.instance_eval do
        keys.each do |k|
          next if @@permanent_attributes.include?(k)
          k_eq = :"#{k}="
          remove_method(k) if method_defined?(k)
          remove_method(k_eq) if method_defined?(k_eq)
        end
      end
    end

    def add_accessors(keys)
      metaclass.instance_eval do
        keys.each do |k|
          next if @@permanent_attributes.include?(k)
          k_eq = :"#{k}="
          define_method(k) { @values[k] }
          define_method(k_eq) do |v|
            @values[k] = v
            @unsaved_values.add(k)
          end
        end
      end
    end    
  end

end