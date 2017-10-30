module ActionView
  module Helpers
    module Tags
      # https://github.com/rails/rails/blob/bdc581616b760d1e2be3795c6f0f3ab4b1e125a5/actionview/lib/action_view/helpers/tags/text_field.rb
      class PrometheeEditor < HiddenField
        def render
          options = @options.stringify_keys
          options["type"] ||= field_type
          options["value"] = options.fetch("value") { value_before_type_cast(object) }
          options["value"] = options["value"].to_json unless options["value"].is_a? String
          add_default_name_and_id(options)

          # TODO: implement
          ('Here is the Prométhée editor 🖌' + tag("input", options)).html_safe
        end

        class << self
          def field_type
            'hidden'
          end
        end
      end
    end
  end
end
