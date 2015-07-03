Gem::Specification.new do |s| 
 s.name = 'cesar' 
 s.version = '0.0.0' 
 s.date = '2015-07-03' 
 s.summary = 'Integrate JasperReport in ruby MRI apps'
 s.description = 'JasperReport for ruby MRI enviroments'
 s.authors = ["Emanuel Friedrich"] 
 s.email = 'aemanuelfriedrich@gmail.com' 
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