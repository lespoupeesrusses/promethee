class Promethee::Component::Collection < Array
  def to_ary
    map &:to_hash
  end
  alias_method :to_a, :to_ary
  alias_method :as_json, :to_ary

  def to_html
    map(&:to_html).join.html_safe
  end

  def self.from data
    raise "Invalid data provided, expected a Array got a #{data.class}." unless data.is_a? Array

    new data.map{ |component| Promethee::Component.from component }
  end
end
