module Promethee::Rails::Helper
  def promethee(data)
    ApplicationController.renderer.render partial: 'promethee/show', locals: { data: data }
    # Promethee::Grid.new(data).show
  end

  def promethee_template(type)
    render "/promethee/#{'components/' unless [:component, :components].include? type.to_s.to_sym }#{type}_edit"
  end

  def promethee_templates
    Promethee::Component.types.map{ |type| promethee_template type }.join.html_safe
  end

  def promethee_class_for component
    "promethee__component promethee__component--#{component[:type]}"
  end

  def promethee_editor_for(type)
    component_class = type.to_s.classify
    component = type[0].downcase + type[1..-1]

    content_tag :div, 'ng-controller': "#{component_class} as #{component}", 'ng-init': "#{component}.data = data" do
      concat yield(Promethee::Component.as(type))
    end
  end
end
