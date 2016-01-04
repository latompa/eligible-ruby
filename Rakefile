require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.fail_on_error = false
end

Rake::TestTask.new(:test)

task default: [:rubocop, :test]
