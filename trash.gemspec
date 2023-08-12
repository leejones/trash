Gem::Specification.new do |s|
  s.name = "trash".freeze
  s.version = "0.2.1"

  s.require_paths = ["lib".freeze]
  s.authors = ["Lee Jones".freeze]
  s.date = "2017-01-24"
  s.description = "when it's hard to say goodbye, and rm is just too much... use trash instead.".freeze
  s.email = "scribblethink@gmail.com".freeze
  s.executables = ["trash".freeze]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    ".document",
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
  s.homepage = "http://github.com/leejones/trash".freeze
  s.licenses = ["MIT".freeze]
  s.summary = "trash can for the command line".freeze
end
