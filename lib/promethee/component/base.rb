class Promethee::Component::Base
  attr_reader :attributes, :children

  def initialize(attributes: {}, children: [])
    @attributes = self.class.attributes.copy attributes
    @children = Promethee::Component::Collection.new children
  end

  def to_hash *options
    {
      type: type,
      attributes: attributes.to_hash,
      children: children.to_ary
    }
  end
  alias_method :to_h, :to_hash
  alias_method :as_json, :to_hash

  def to_html
    ApplicationController.renderer.render partial: "promethee/components/#{type}", locals: { component: self }
  end

  def [](method)
    send method
  end

  def class_name
    "promethee__component promethee__component--#{type}"
  end

  def type
    self.class.type
  end

  def self.attributes
    @attributes ||= Promethee::Component::Attributes.new
  end

  def self.children
    @children ||= []
  end

  def self.type
    to_s.split('::').last.underscore.to_sym
  end

  def self.final?
    children.empty?
  end

  # def self.class_name
  #   "promethee-editor__component promethee__component--#{type}#{' promethee__component--final' if final?}"
  # end

  private

  def self.has_attributes
    yield Promethee::Component::Attributes::Definer.new(self) if block_given?
  end

  def self.has_children *components
    children.concat(components.flatten.map{ |component| component.is_a?(Class) && component < self ? component : Promethee::Component.as(component) }).uniq!
  end

  class << self
    alias_method :has_child, :has_children
  end
end
