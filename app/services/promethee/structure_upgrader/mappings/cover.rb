class Promethee::StructureUpgrader::Mappings::Cover
  def self.type_mappings
    {
      image: 'blob',
      surtitle: 'string',
      title: 'string',
      subtitle: 'string'
    }
  end
end