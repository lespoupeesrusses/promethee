ActionView::Helpers::FormBuilder.class_eval do
  # https://github.com/rails/rails/blob/13c5aa818e9284fe30f83469b340e579195bda3f/actionview/lib/action_view/helpers/form_helper.rb#L2148
  def promethee(method, options = {})
    @template.promethee_editor(@object_name, method, objectify_options(options))
  end

  def promethee_localizer(method, options = {})
    @template.promethee_localizer(@object_name, method, objectify_options(options))
  end
end
