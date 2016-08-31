# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eligible/version'

Gem::Specification.new do |gem|
  gem.name          = 'eligible'
  gem.version       = Eligible::VERSION
  gem.authors       = ['Katelyn Gleaon', 'Rodrigo Dominguez', 'Aaron Bedra']
  gem.email         = ['k@eligible.com', 'rod@eligible.com', 'abedra@eligible.com']
  gem.description   = 'Eligible is a developer-friendly way to process health care eligibility checks. Learn more at https://eligible.com'
  gem.summary       = 'Ruby wrapper for the Eligible API'
  gem.homepage      = 'https://github.com/eligible/eligible-ruby'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  gem.require_paths = ['lib']

  gem.add_dependency('rest-client', '~> 1.8')
  gem.add_dependency('multi_json', '~> 1.7')

  gem.add_development_dependency('rake', '~> 10.5')
  gem.add_development_dependency('rspec', '~> 3.4')
  gem.add_development_dependency('rubocop', '= 0.35.0')
  gem.add_development_dependency('simplecov', '~> 0.11')
end
