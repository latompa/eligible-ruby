require 'simplecov'
SimpleCov.minimum_coverage 51
SimpleCov.start do
  add_filter "/spec/"
end if ENV["COVERAGE"]

require 'rspec'
require 'eligible'
require 'pry-rails'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'default'
end