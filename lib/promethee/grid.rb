class Promethee::Grid
  include ActionView::Helpers::FormTagHelper

  attr_accessor :data, :name, :id

  def initialize(data = [], name: nil, id: id)
    self.data = data
    self.name = name
    self.id = id
  end

  def components
    Promethee::Component::Collection.from data
  end

  def value
    data.is_a?(String) ? data : data.to_json
  end

  def input options = {}
    hidden_field_tag name, value, options
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
