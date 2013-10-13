require "rspec/core/rake_task"

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

RSpec::Core::RakeTask.new

task :default => [:spec]

namespace :spec do
  RSpec::Core::RakeTask.new(:unit) do |task|
    task.pattern = 'spec/bdd/**/*_spec.rb'
  end
end
