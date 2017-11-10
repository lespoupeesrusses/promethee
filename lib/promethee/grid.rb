class Promethee::Grid
  include ActionView::Helpers::FormTagHelper

  attr_accessor :data, :name, :id

  def initialize(data = [], name: nil, id: nil)
    self.data = data
    self.name = name
    self.id = id.nil? ? self.class.id : id
  end

  def components
    Promethee::Component::Collection.from data
  end

  # def value
  #   data.is_a?(String) ? data : data.to_json
  # end

  def input options = {}
    hidden_field_tag name, '{{promethee.data}}', options
  end

  # def to_javascript
  #   <<-JAVASCRIPT.html_safe
  #     new Promethee(#{id.to_json}, #{data.to_json})
  #   JAVASCRIPT
  # end
  # alias_method :to_js, :to_javascript

  def template(type)
    ApplicationController.renderer.render partial: "/promethee/#{'components/' unless [:component, :components].include? type.to_s.to_sym }#{type}_edit", locals: { promethee: self }
  end

  def templates
    Promethee::Component.types.map{ |type| template type }.join.html_safe
  end

  def edit
    ApplicationController.renderer.render partial: 'promethee/edit', locals: { promethee: self }
  end

  def show
    ApplicationController.renderer.render partial: 'promethee/show', locals: { promethee: self }
  end

  private

  def self.id
    "promethee-#{SecureRandom.hex 10}"
  end
end
