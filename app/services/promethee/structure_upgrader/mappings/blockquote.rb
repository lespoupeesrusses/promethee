class Promethee::StructureUpgrader::Mappings::Blockquote
  def self.type_mappings
    {
      body: 'text',
      author: 'string'
    }
  end
end