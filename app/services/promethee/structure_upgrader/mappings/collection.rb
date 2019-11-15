class Promethee::StructureUpgrader::Mappings::Collection
  def self.type_mappings
    {
      items_per_line: 'enum'
    }
  end

  def self.enums_collections
    {
      items_per_line: [
        { label: '2', value: 2 },
        { label: '3', value: 3 },
        { label: '4', value: 4 },
        { label: '6', value: 6 }
      ]
    }
  end
end