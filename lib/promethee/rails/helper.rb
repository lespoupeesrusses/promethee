module Promethee::Rails::Helper
  def promethee(data, options = {})
    render partial: 'promethee/show', locals: { master_data: data, localization_data: options[:l] }
  end

  def promethee_class_for(component, *modifiers)
    base = "promethee__component"
    component_base = "#{base}__#{component[:type]}"

    [
      base,
      component_base,
      modifiers.map { |modifier| "#{component_base}--#{modifier}" }
    ].flatten.select(&:present?).join ' '
  end

  def promethee_id_for(component)
    "promethee-component-#{component[:id]}"
  end

  def promethee_component_partials
    promethee_partials_for 'components/*/_edit.*.html.erb'
  end

  def promethee_component_render_icon(icon)
    render("promethee/components/#{icon}/icon.svg").to_json.html_safe
  end

  def promethee_util_partials
    promethee_partials_for 'utils/_*.html.erb'
  end

  def promethee_template_partials
    promethee_partials_for 'templates/_*.html.erb'
  end

  def promethee_preset_partials
    promethee_partials_for 'presets/_*.html.erb'
  end

  def promethee_localize_partials
    promethee_partials_for 'components/*/_localize.html.erb'
  end

  def blob_from_data(blob_data = {})
    return unless blob_data&.has_key? :id
    ActiveStorage::Blob.find_signed(blob_data[:id]) rescue nil
  end

  # promethee_bem_classes 'promethee-edit__move__droppable', '--{{type}}', '--first'
  # -> promethee-edit__move__droppable promethee-edit__move__droppable--{{type}} promethee-edit__move__droppable--{{type}}--first"
  def promethee_bem_classes(*args)
    classes = ''
    current_class = ''
    args.each do |arg|
      current_class << arg
      classes << "#{current_class} "
    end
    classes
  end

  protected

  # Example:  promethee_partials_for 'components/*/_edit.*.html.erb'
  # [
  #   'promethee/components/column/edit.define',
  #   'promethee/components/column/edit.inspect',
  #   'promethee/components/column/edit.move',
  #   'promethee/components/column/edit.write',
  #   'promethee/components/cover/edit.define',
  #   'promethee/components/cover/edit.inspect',
  #   ...
  # ]
  def promethee_partials_for(path)
    promethee_partial_paths_for(path).map { |path| (path.dirname + path.basename('.html.erb').to_s[1..-1]).to_s }
  end

  # Example: promethee_partial_paths_for 'components/*/_edit.*.html.erb'
  # [
  #   Pathname:promethee/components/column/_edit.define.html.erb,
  #   Pathname:promethee/components/column/_edit.inspect.html.erb,
  #   Pathname:promethee/components/column/_edit.move.html.erb,
  #   Pathname:promethee/components/column/_edit.write.html.erb,
  #   Pathname:promethee/components/cover/_edit.define.html.erb,
  #   Pathname:promethee/components/cover/_edit.inspect.html.erb,
  #   ...
  # ]
  def promethee_partial_paths_for(path)
    promethee_partial_sources.map do |source|
      Dir[source + 'promethee' + path].map { |file| Pathname.new(file).relative_path_from source }
    end.flatten.uniq(&:to_s)
  end

  # Example:
  # [
  #   Pathname:/Users/lespoupeesrusses/Developer/a-rails-app/app/views,
  #   Pathname:/Users/lespoupeesrusses/.rbenv/versions/2.3.3/lib/ruby/gems/2.3.0/gems/promethee-1.2.12/app/views
  # ]
  def promethee_partial_sources
    [Rails.root, Promethee.root].map { |source| source + 'app/views' }
  end
end
