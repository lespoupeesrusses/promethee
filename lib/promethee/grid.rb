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

  def to_javascript
    <<-JAVASCRIPT.html_safe
      var promethee = new Promethee(#{id.to_json}, #{data.to_json});
      promethee.initialize();
    JAVASCRIPT
  end
  alias_method :to_js, :to_javascript

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
