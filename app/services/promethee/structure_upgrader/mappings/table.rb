class Promethee::StructureUpgrader::Mappings::Table
  def self.type_mappings
    {
      cols: 'array',
      cols_data: 'hash',
      rows: 'array',
      rows_data: 'hash'
    }
  end

  def self.items_type_mappings
    {
      cols_data: {
        searchable_text: 'string'
      },
      rows_data: {
        '*': {
          searchable_text: 'string'
        }
      }
    }
  end
end