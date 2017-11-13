$:.push File.expand_path('../lib', __FILE__)

require 'promethee/rails/version'

Gem::Specification.new do |s|
  s.name        = 'promethee'
  s.version     = Promethee::Rails::VERSION
  s.authors     = ['Julien Dargelos', 'Arnaud Levy', 'Pierre-André Boissinot', 'Antoine Prévost']
  s.email       = ['contact@juliendargelos.com', 'alevy@lespoupees.paris', 'paboissinot@lespoupees.paris', 'aprevost@lespoupees.paris']

  s.summary     = 'Bring fire to your page'
  s.homepage    = 'https://github.com/lespoupeesrusses/promethee'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib,vendor}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.3'
  s.add_dependency 'angularjs-rails', '~> 1.6.2'
  s.add_dependency 'angular-ui-tinymce-rails'
  s.add_dependency 'bootstrap-sass', '~> 3.3.6'
  s.add_dependency 'sass-rails', '>= 3.2'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'tinymce-rails'
  s.add_dependency 'material_icons'
  s.add_dependency 'angular_rails_csrf'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'byebug'
end
