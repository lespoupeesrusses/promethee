module Promethee::Component
  def self.types
    Base.descendants.map &:type
  end

  def self.as type
    begin
      class_name = "::Promethee::Component::#{type.to_s.classify}"
      require "promethee/component/#{type}" unless Object.const_defined? class_name
      class_name.constantize
    rescue LoadError
      raise "Unknown Prométhée component type \"#{type}\". Available types: \"#{types.join '", "'}\"."
    end
  end

  def self.from data
    raise "Invalid data provided, expected a Hash got a #{data.class}." unless data.is_a? Hash

    data = data.deep_dup

    data[:attributes] = {} unless data[:attributes].is_a? Hash
    data[:children] = [] unless data[:children].is_a? Array

    data[:children].map! { |data| from data }

    as(data[:type]).new attributes: data[:attributes], children: data[:children]
  end
end
