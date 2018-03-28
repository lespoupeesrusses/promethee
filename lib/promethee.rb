require 'bootstrap-sass'
require 'font-awesome-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'angularjs-rails'

module Promethee
  def self.root
    Pathname.new(__dir__).parent.realpath
  end

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
