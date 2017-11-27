module Promethee::Rails::Helper
  def promethee(data, options = {})
    ApplicationController.renderer.render partial: 'promethee/show', locals: { data: data, l: options[:l] }
  end

  def promethee_class_for component
    "promethee__component promethee__component--#{component[:type]}"
  end
end
