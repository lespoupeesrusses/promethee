module Promethee::Rails::Helper
  def promethee(data, options = {})
    ApplicationController.renderer.render partial: 'promethee/show', locals: { master_data: data, localization_data: options[:l] }
  end

  def promethee_class_for component
    "promethee__component promethee__component--#{component[:type]}"
  end

  # [
  #   Pathname:promethee/components/column/edit.define,
  #   Pathname:promethee/components/column/edit.inspect,
  #   Pathname:promethee/components/column/edit.move,
  #   Pathname:promethee/components/column/edit.write,
  #   Pathname:promethee/components/cover/edit.define,
  #   Pathname:promethee/components/cover/edit.inspect,
  #   ...
  # ]
  def promethee_component_partials
    promethee_component_partial_paths.map { |path| (path.dirname + path.basename('.html.erb').to_s[1..-1]).to_s }
  end

  protected

  # [
  #   Pathname:promethee/components/column/_edit.define.html.erb,
  #   Pathname:promethee/components/column/_edit.inspect.html.erb,
  #   Pathname:promethee/components/column/_edit.move.html.erb,
  #   Pathname:promethee/components/column/_edit.write.html.erb,
  #   Pathname:promethee/components/cover/_edit.define.html.erb,
  #   Pathname:promethee/components/cover/_edit.inspect.html.erb,
  #   ...
  # ]
  def promethee_component_partial_paths
    promethee_component_partial_sources.map do |source|
      Dir[source + 'promethee/components/*/_edit.*.html.erb'].map { |file| Pathname.new(file).relative_path_from source }
    end.flatten.uniq(&:to_s)
  end

  # [
  #   Pathname:/Users/lespoupeesrusses/Developer/a-rails-app/app/views,
  #   Pathname:/Users/lespoupeesrusses/.rbenv/versions/2.3.3/lib/ruby/gems/2.3.0/gems/promethee-1.2.12/app/views
  # ]
  def promethee_component_partial_sources
    [Rails.root, Promethee.root].map { |source| source + 'app/views' }
  end
end
