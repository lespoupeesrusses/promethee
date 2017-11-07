module Promethee::Rails::Helper
  def promethee(data)
    Promethee::Grid.new(data).show
  end

  def promethee_template(type, once: true)
    type = type.to_s.to_sym
    @promethee_templates ||= {}

    return if @promethee_templates[type] && once
    @promethee_templates[type] = true

    content_tag :script, render("/promethee/edit/#{type}").html_safe, type: 'text/ng-template', id: "promethee/#{type}"
  end

  def promethee_templates(once: true)
    Promethee::Component.types.map{ |type| promethee_template type, once: once }.join.html_safe
  end
end
