class Promethee::StructureUpgrader::Mappings::FaqItem
  def self.type_mappings
    {
      image: 'blob',
      title: 'string',
      body: 'text',
      special_question: 'boolean'
    }
  end
end