module Promethee::Rails::Helper
  def promethee(data, options = {})
    ApplicationController.renderer.render partial: 'promethee/show', locals: { master_data: data, localization_data: options[:l] }
  end

  def promethee_class_for component, *modifiers
    base = "promethee__component"
    component_base = "#{base}--#{component[:type]}"

    [
      base,
      component_base,
      modifiers.map { |modifier| "#{component_base}--#{modifier}" }
    ].flatten.select(&:present?).join ' '
  end

  def promethee_component_partials
    promethee_partials_for 'components/*/_edit.*.html.erb'
  end

  def promethee_util_partials
    promethee_partials_for 'utils/_*.html.erb'
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
