require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "trash"
    gem.summary = %Q{trash can for the command line}
    gem.description = %Q{when it's hard to say goodbye, and rm is just too much... use trash instead.}
    gem.email = "scribblethink@gmail.com"
    gem.homepage = "http://github.com/leejones/trash"
    gem.authors = ["Lee Jones"]
    gem.add_development_dependency "rspec", "~> 2.14.1"
    gem.add_development_dependency "rake", "~> 10.1.0"
    gem.add_development_dependency "jeweler", "~> 1.8.7"
    gem.add_development_dependency "rdoc", "~> 4.0.1"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "trash #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
