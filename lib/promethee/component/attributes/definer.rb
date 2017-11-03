class Promethee::Component::Attributes::Definer
  attr_reader :component

  def initialize(component)
    @component = component
  end

  ::Promethee::Component::Attribute::Base.descendants.each do |attribute|
    define_method attribute.type do |name, default: nil|
      component.attributes << attribute.new(name, default)
    end
  end
end
