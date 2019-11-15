class Promethee::StructureUpgrader::Mappings::SliderItem
  def self.type_mappings
    {
      caption: 'text',
      media_type: 'enum',
      image: 'blob',
      video: 'video'
    }
  end

  def self.enums_collections
    {
      media_type: [
        { label: 'Image', value: 'image' },
        { label: 'Video', value: 'video' }
      ]
    }
  end
end