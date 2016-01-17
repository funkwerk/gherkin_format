task default: :build

desc 'Builds the Gem.'
task build:  :test do
  sh 'gem build gherkin_format.gemspec'
end

task test: :rubocop
task :test do
  sh 'cucumber'
end

desc 'Publishes the Gem'
task :push do
  sh 'gem push gherkin_format-0.0.5.gem'
end

desc 'Checks ruby style'
task :rubocop do
  sh 'rubocop'
end
