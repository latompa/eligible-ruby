require "eligible/version"

module Eligible
  @@api_key = nil

  def self.api_key
    @@api_key
  end

  def self.api_key=(api_key)
    @@api_key = api_key
  end  
end
