require 'bootstrap-sass'
require 'font-awesome-rails'
require 'material_icons'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'tinymce-rails'
require 'angularjs-rails'
require 'angular-ui-tinymce/rails'
require 'angular_rails_csrf'

module Promethee
  module Rails
    require 'promethee/rails/helper'
    require 'promethee/rails/engine'
    require 'promethee/rails/version'
  end

  require 'promethee/core_ext/tags'
  require 'promethee/core_ext/form_helper'
  require 'promethee/core_ext/form_builder'

  require 'promethee/configuration'
  require 'promethee/data'
end
