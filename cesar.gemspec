require File.expand_path("../lib/cesar", __FILE__)

Gem::Specification.new do |s| 
  s.name = 'cesar' 
  s.version = Cesar::VERSION 
  s.date = Date.today.to_s 
  s.summary = 'Integrate JasperReport in ruby MRI apps'
  s.description = 'JasperReport for ruby MRI enviroments'
  s.authors = ["Emanuel Friedrich"] 
  s.email = 'aemanuelfriedrich@gmail.com' 
  s.homepage = 'https://github.com/emafriedrich/cesar'
  s.files = Dir[
  #  "LICENSE",
  #  "AUTHORS",
    "README.md",
    "lib/**/*.rb",
    "utils/*",
    "utils/lib/*",
    "*.gemspec",
    "test/**/*.rb", 
    "makefile"
  ]
  s.add_development_dependency "cutest"
end