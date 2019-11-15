class Promethee::StructureUpgraderService
  TYPE_MAPPINGS = {
    aside: Promethee::StructureUpgrader::Mappings::Aside,
    blockquote: Promethee::StructureUpgrader::Mappings::Blockquote,
    collection: Promethee::StructureUpgrader::Mappings::Collection,
    collection_item: Promethee::StructureUpgrader::Mappings::CollectionItem,
    column: Promethee::StructureUpgrader::Mappings::Column,
    cover: Promethee::StructureUpgrader::Mappings::Cover,
    faq: Promethee::StructureUpgrader::Mappings::Faq,
    faq_item: Promethee::StructureUpgrader::Mappings::FaqItem,
    image: Promethee::StructureUpgrader::Mappings::Image,
    page: Promethee::StructureUpgrader::Mappings::Page,
    row: Promethee::StructureUpgrader::Mappings::Row,
    slider: Promethee::StructureUpgrader::Mappings::Slider,
    slider_item: Promethee::StructureUpgrader::Mappings::SliderItem,
    table: Promethee::StructureUpgrader::Mappings::Table,
    text: Promethee::StructureUpgrader::Mappings::Text,
    video: Promethee::StructureUpgrader::Mappings::Video
  }

  def self.upgrade(data)
    @data = data
    process_component(@data)
  end

  private

  def process_component(data)
    data[:attributes] = process_attributes(data[:attributes], data[:type])
    data[:children].map! do |child|
      process_component child
    end
  end

  def process_attributes(attributes, component_type, namespace = '')
    mapping = TYPE_MAPPINGS[component_type.to_sym]
    new_attributes = {}

    attributes.each do |attr_name, attr_value|
      new_attr_name = attr_name.to_s
      is_searchable = new_attr_name.gsub!(/searchable_/, '').present?
      attr_type = mapping.type_mappings[new_attr_name.to_sym]

      new_attributes[new_attr_name.to_sym] = {
        searchable: is_searchable,
        type: attr_type,
        value: attr_value
      }
    end

    new_attributes
  end
end