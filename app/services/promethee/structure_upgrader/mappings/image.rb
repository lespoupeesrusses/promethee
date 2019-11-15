class Promethee::StructureUpgrader::Mappings::Image
  def self.type_mappings
    {
      image: 'blob',
      alt: 'string',
      caption: 'text'
    }
  end
end