module Promethee::Rails::Helper
  def promethee(data)
    Promethee::Grid.new(data).show
  end

  def promethee_template(type)
    render "/promethee/edit/#{type}"
  end

  def promethee_templates
    Promethee::Component.types.map{ |type| promethee_template type }.join.html_safe
  end
end
