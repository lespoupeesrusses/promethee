require 'bootstrap-sass'
require 'font-awesome-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'tinymce-rails'
require 'angularjs-rails'
require 'angular-rails-templates'
require 'angular-ui-tinymce/rails'

module Promethee
  module Rails
    require 'promethee/rails/helper'
    require 'promethee/rails/engine'
    require 'promethee/rails/version'
    require 'promethee/core_ext/tags'
    require 'promethee/core_ext/form_helper'
    require 'promethee/core_ext/form_builder'
  end
end
