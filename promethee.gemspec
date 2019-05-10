$:.push File.expand_path('../lib', __FILE__)

require 'promethee/rails/version'

Gem::Specification.new do |s|
  s.name        = 'promethee'
  s.version     = Promethee::Rails::VERSION
  s.authors     = ['Sébastien Gaya', 'Julien Dargelos', 'Arnaud Levy', 'Pierre-André Boissinot', 'Antoine Prévost', 'Alexis Rousseau', 'Steven Ing']
  s.email       = ['sebastien.gaya@gmail.com', 'julien.dargelos@me.com', 'alevy@lespoupees.paris', 'paboissinot@lespoupees.paris', 'aprevost@lespoupees.paris', 'arousseau@lespoupees.paris', 'sing@lespoupees.paris']

  s.summary     = 'Bring fire to your page'
  s.homepage    = 'https://github.com/lespoupeesrusses/promethee'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib,node_modules}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 5.2'
  s.add_dependency 'angularjs-rails', '~> 1.6.2'
  s.add_dependency 'sassc-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'mini_magick'
  s.add_dependency 'font-awesome-sass'
  s.add_dependency 'summernote-rails', '~> 0.8.10.0'
  s.add_dependency 'deep_merge_existing_keys'

  s.add_development_dependency 'byebug'
end
