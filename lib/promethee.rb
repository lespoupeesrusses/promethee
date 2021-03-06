require 'font-awesome-sass'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'angularjs-rails'
require 'summernote-rails'
require 'deep_merge_existing_keys'

module Promethee
  def self.root
    Pathname.new(__dir__).parent.realpath
  end

  module Rails
    require 'promethee/rails/helper'
    require 'promethee/rails/engine'
    require 'promethee/rails/version'
  end

  require 'promethee/core_ext/form_helper'
  require 'promethee/core_ext/form_builder'
  require 'promethee/core_ext/mapper'
  require 'promethee/core_ext/tags'

  require 'promethee/data'
  require 'promethee/data/master'
  require 'promethee/data/master_localized'
  require 'promethee/data/masters_multiple'
  require 'promethee/data/localization'
end
