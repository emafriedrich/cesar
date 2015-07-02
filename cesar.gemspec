require 'lib/cesar'

Gem::Specification.new do |s| 
 s.name = 'cesar' 
 s.version = '0.0.0' 
 s.date = '2015-06-23' 
 s.summary = 'Integrate JasperReport in ruby apps'
 s.description = 'JasperReport for ruby enviroments'
 s.authors = ["Emanuel Friedrich"] 
 s.email = 'aemanuelfriedrich@gmail.com' 
  s.files = Dir[
  #  "LICENSE",
  #  "AUTHORS",
    "README.md",
    "lib/**/*.rb",
    "lib/utils/**",
    "*.gemspec",
    "test/**/*.rb", 
    "makefile"
  ]
  s.add_development_dependency "cutest"
end