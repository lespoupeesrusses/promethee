class Promethee::StructureUpgrader::Mappings::Column
  def self.type_mappings
    {
      size: 'integer',
      offset: 'integer',
      mobile: {
        enabled: 'boolean',
        size: 'integer',
        offset: 'integer'
      },
      tablet: {
        enabled: 'boolean',
        size: 'integer',
        offset: 'integer'
      }
    }
  end
end