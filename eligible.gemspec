# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eligible/version'

Gem::Specification.new do |gem|
  gem.name          = "eligible"
  gem.version       = Eligible::VERSION
  gem.authors       = ["Andy Brett"]
  gem.email         = ["andy@andybrett.com"]
  gem.description   = 'Eligible is a developer-friendly way to process health care eligibility checks. Learn more at https://eligibleapi.com'
  gem.summary       = 'Ruby wrapper for the Eligible API'
  gem.homepage      = "https://eligibleapi.com/"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  # gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.test_files    = `git ls-files -- test/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_development_dependency('mocha')
  gem.add_development_dependency('shoulda')
  gem.add_development_dependency('test-unit')
  gem.add_development_dependency('rake')

  gem.add_dependency('rest-client', '~> 1.4')
  gem.add_dependency('multi_json', '>= 1.0.4', '< 2')
end
