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
  end

  require 'promethee/component'
  require 'promethee/component/attribute'
  require 'promethee/component/attribute/boolean'
  require 'promethee/component/attribute/integer'
  require 'promethee/component/attribute/float'
  require 'promethee/component/attribute/string'

  require 'promethee/component/attributes'
  require 'promethee/component/attributes/definer'

  require 'promethee/component/base'
  require 'promethee/component/collection'
  require 'promethee/component/row'
  require 'promethee/component/column'
  require 'promethee/component/text'
  require 'promethee/component/image'
  require 'promethee/component/video'

  require 'promethee/grid'

  require 'promethee/core_ext/tags'
  require 'promethee/core_ext/form_helper'
  require 'promethee/core_ext/form_builder'
end
