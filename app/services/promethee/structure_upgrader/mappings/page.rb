class Promethee::StructureUpgrader::Mappings::Page
  def self.type_mappings
    {
      title: 'string',
      description: 'text',
      thumbnail: 'blob',
      stylesheets: 'string',
      javascripts: 'string'
    }
  end
end