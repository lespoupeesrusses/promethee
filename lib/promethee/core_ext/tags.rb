require 'promethee'

module ActionView
  module Helpers
    module Tags
      # https://github.com/rails/rails/blob/bdc581616b760d1e2be3795c6f0f3ab4b1e125a5/actionview/lib/action_view/helpers/tags/text_field.rb
      class PrometheeEditor < Base
        def render
          master_data = object.send @method_name unless object.nil?
          master_data = @options[:value] if @options.include? :value
          ApplicationController.renderer.render partial: 'promethee/edit', locals: { master_data: master_data }
        end
      end

      class PrometheeLocalizer < Base
        def render
          localization_data = object.send @method_name unless object.nil?
          localization_data = @options[:value] if @options.include? :value
          master_data = @options[:master]
          ApplicationController.renderer.render partial: 'promethee/localize', locals: { localization_data: localization_data, master_data: master_data }
        end
      end
    end
  end
end
