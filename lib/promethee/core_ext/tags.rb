require 'promethee'

module ActionView
  module Helpers
    module Tags
      # https://github.com/rails/rails/blob/bdc581616b760d1e2be3795c6f0f3ab4b1e125a5/actionview/lib/action_view/helpers/tags/text_field.rb
      class PrometheeEditor < Base
        def render
          options = @options.stringify_keys
          add_default_name_and_id(options)
          data = options.fetch("value") { value_before_type_cast(object) }

          Promethee::Grid.new(data, name: options["name"]).edit
        end
      end
    end
  end
end
