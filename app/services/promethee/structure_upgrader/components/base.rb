module Promethee::StructureUpgrader::Components
  class Base
    def initialize(data)
      @data = data
      # puts "<#{self.class}> Initialized."

      upgrade
    end

    def upgraded_data
      @upgraded_data
    end

    def upgrade
      @upgraded_data = @data.deep_dup
      @upgraded_data['attributes'] = upgraded_attributes.deep_stringify_keys
    end

    def upgraded_attributes
      raise NotImplementedError
    end

    protected

    def string_attribute(*path)
      text = attribute(*path)
      Loofah.fragment(text).text(encode_special_chars: false)
    end

    def attribute(*path)
      @data.dig('attributes', *path)
    end
  end
end