require 'rake/testtask'

task default: :build

desc 'Builds the Gem.'
task build:  :test do
  sh 'gem build gherkin_format.gemspec'
end

task test: :rubocop
Rake::TestTask.new do |t|
  t.libs << 'test'
end

task test: :cli_test
task :cli_test do
  gherkin_format(%w(test/clean.feature))
end

def gherkin_format(args)
  sh "RUBYLIB=lib/#{ENV['RUBYLIB']} bin/gherkin_format #{args.join ' '}"
end

desc 'Publishes the Gem'
task :push do
  sh 'gem push gherkin_format-1.0.0-gem'
end

desc 'Checks ruby style'
task :rubocop do
  sh 'rubocop'
end
