Gem::Specification.new do |s|
  s.name        = 'rescue_from_api'
  s.version     = '0.1.0'
  s.date        = '2017-03-02'
  s.summary     = "Exception Handler for Rails APIs"
  s.description = "Quick and easy way to handle common exceptions in Rails APIs"
  s.authors     = ["Tejas Bubane"]
  s.email       = 'tejasbubane@gmail.com'
  s.files       = ["lib/api_rescuable.rb"]
  s.homepage    = 'http://rubygems.org/gems/api_rescuable'
  s.license     = 'MIT'

  s.require_path = "lib"
  s.requirements << "none"

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rails', '5.0.2'
end
