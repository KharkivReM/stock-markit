require 'rspec/core/rake_task'
require 'coveralls/rake/task'

Coveralls::RakeTask.new
RSpec::Core::RakeTask.new(:spec) do
  # put any setup here that you may need...
end

desc "Test the code with code coverage"
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task["spec"].execute
end

# Run the tests and build a test package by default
task :default => ['clean','spec','gem:build']

desc "Test the code"
task :test => [:clean, :spec] do
  sh 'bundle exec rspec --format RspecJunitFormatter  --out ./spec_results.xml'
end

desc "Clean up"
task :clean => ['gem:clean'] do
  sh 'rm -rf ./spec_results.xml'
  sh 'rm -rf ./coverage'
  sh 'rm -rf ./tmp'
end

desc "Install dependencies"
task :deps do
  sh 'bundle install'
end

desc "Build and install Gem locally"
task :gem => ['gem:install']

namespace :gem do

  desc "Clean up any built gems"
  task :clean do
    sh "rm -rf *.gem"
  end

  desc "Build the gem"
  task :build do
    sh "gem build ./*.gemspec"
  end

  desc "Install the gem"
  task :install => [:clean, :build] do
    sh "gem install ./*.gem"
  end

end
