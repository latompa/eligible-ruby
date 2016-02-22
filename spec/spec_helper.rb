require 'simplecov'

SimpleCov.start do
  ## remove anything outside eligible lib
  ## it specifically removes .bundle and spec
  add_filter do |src|
    !(src.filename =~ /\/lib\/eligible/)
  end

  Dir[SimpleCov.root + '/lib/**/*/'].each { |dir|
    add_group File.basename(dir).capitalize, dir
  }

  minimum_coverage 51
end

require 'rspec'
require 'eligible'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'default'
end
