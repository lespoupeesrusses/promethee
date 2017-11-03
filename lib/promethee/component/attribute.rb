module Promethee::Component::Attribute
  class Base
    attr_reader :name, :value

    def initialize name, value = default
      @name = name.to_s.to_sym
      self.value = value
    end

    def value= value
      @value = value == default ? default : cast(value)
    end

    def default
      self.class.default
    end

    def cast value
      self.class.cast.call value
    end

    def dup
      self.class.new name, (value.dup rescue value)
    end

    private

    def self.type
      to_s.split('::').last.underscore
    end

    def self.default value = nil
      @value = value unless value.nil?
      @value
    end

    def self.cast &block
      @cast = block if block_given?
      @cast ||= -> (value) { value }
    end
  end
end
