class Promethee::Component::Attributes
  def update hash
    (names & hash.keys.map(&:to_sym)).each { |name| attributes[name].value = hash[name] }

    self
  end

  def to_hash
    attributes.map{ |name, attribute|  [name, attribute.value] }.to_h
  end
  alias_method :to_h, :to_hash
  alias_method :as_json, :to_hash

  def [](method)
    send method
  end

  def keys
    attributes.keys
  end
  alias_method :names, :keys

  def each &block
    attributes.values.each &block
  end

  def << attribute
    attributes[attribute.name] = attribute

    define_singleton_method(attribute.name) { attribute.value }
    define_singleton_method("#{attribute.name}=") { |value| attribute.value = value }
  end

  def dup
    duplicate = self.class.new
    each { |attribute| duplicate << attribute.dup }

    duplicate
  end

  def copy hash
    dup.update hash
  end

  private

  def attributes
    @attributes ||= {}
  end
end
