class Promethee::StructureUpgrader::Mappings::Aside
  def self.type_mappings
    {
      visible_content: 'text',
      collapsed_content: 'text',
      open_label: 'string',
      open_label_position: 'enum'
    }
  end

  def self.enums_collections
    {
      open_label_position: [
        { label: 'Left', value: 'left' },
        { label: 'Right', value: 'right' },
        { label: 'Center', value: 'center' }
      ]
    }
  end
end