ActionView::Helpers::FormHelper.class_eval do
  # https://github.com/rails/rails/blob/13c5aa818e9284fe30f83469b340e579195bda3f/actionview/lib/action_view/helpers/form_helper.rb#L1193
  def promethee_editor(object_name, method, options = {})
    ActionView::Helpers::Tags::PrometheeEditor.new(object_name, method, self, options).render
  end
end
