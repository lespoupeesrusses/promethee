require 'promethee'

module ActionView
  module Helpers
    module Tags
      # https://github.com/rails/rails/blob/bdc581616b760d1e2be3795c6f0f3ab4b1e125a5/actionview/lib/action_view/helpers/tags/text_field.rb
      class PrometheeEditor < Base
        def render
          data = object.send @method_name unless object.nil?
          data = @options[:value] if @options.include? :value
          ApplicationController.renderer.render partial: 'promethee/edit', locals: { data: data }
        end
      end

      class PrometheeLocalizer < Base
        def render
          data = object.send @method_name unless object.nil?
          data = @options[:value] if @options.include? :value
          master = @options[:master]
          ApplicationController.renderer.render partial: 'promethee/localize', locals: { data: data, master: master }
        end
      end
    end
  end
end
