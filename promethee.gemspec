$:.push File.expand_path("../lib", __FILE__)

require "promethee/rails/version"

Gem::Specification.new do |s|
  s.name        = "promethee"
  s.version     = Promethee::Rails::VERSION
  s.authors     = ["Julien Dargelos", "Arnaud Levy", "Pierre-André Boissinot", "Antoine Prévost"]
  s.email       = ["contact@juliendargelos.com", "alevy@lespoupees.paris", "paboissinot@lespoupees.paris", "aprevost@lespoupees.paris"]

  s.summary     = "Bring fire to your page"
  s.homepage    = "https://github.com/lespoupeesrusses/promethee"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"
  s.add_development_dependency "sqlite3"
end
