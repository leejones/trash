# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-
# stub: trash 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "trash"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lee Jones"]
  s.date = "2013-09-18"
  s.description = "when it's hard to say goodbye, and rm is just too much... use trash instead."
  s.email = "scribblethink@gmail.com"
  s.executables = ["trash"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc",
     "TODO"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".rspec",
     "Gemfile",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "TODO",
     "VERSION",
     "bin/trash",
     "lib/trash.rb",
     "spec/spec_helper.rb",
     "spec/trash_spec.rb",
     "trash.gemspec"
  ]
  s.homepage = "http://github.com/leejones/trash"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.0"
  s.summary = "trash can for the command line"
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/trash_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.14.1"])
      s.add_development_dependency(%q<rake>, ["~> 10.1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0.1"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.14.1"])
      s.add_dependency(%q<rake>, ["~> 10.1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_dependency(%q<rdoc>, ["~> 4.0.1"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.14.1"])
    s.add_dependency(%q<rake>, ["~> 10.1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
    s.add_dependency(%q<rdoc>, ["~> 4.0.1"])
  end
end

