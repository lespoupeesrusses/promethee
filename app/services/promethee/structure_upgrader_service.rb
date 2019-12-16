class Promethee::StructureUpgraderService
  BASE_COMPONENTS = {
    aside: Promethee::StructureUpgrader::Components::Aside,
    blockquote: Promethee::StructureUpgrader::Components::Blockquote,
    collection: Promethee::StructureUpgrader::Components::Collection,
    collection_item: Promethee::StructureUpgrader::Components::CollectionItem,
    column: Promethee::StructureUpgrader::Components::Column,
    cover: Promethee::StructureUpgrader::Components::Cover,
    faq: Promethee::StructureUpgrader::Components::Faq,
    faq_item: Promethee::StructureUpgrader::Components::FaqItem,
    image: Promethee::StructureUpgrader::Components::Image,
    page: Promethee::StructureUpgrader::Components::Page,
    row: Promethee::StructureUpgrader::Components::Row,
    slider: Promethee::StructureUpgrader::Components::Slider,
    slider_item: Promethee::StructureUpgrader::Components::SliderItem,
    table: Promethee::StructureUpgrader::Components::Table,
    table_cell: Promethee::StructureUpgrader::Components::TableCell,
    text: Promethee::StructureUpgrader::Components::Text,
    video: Promethee::StructureUpgrader::Components::Video
  }

  attr_accessor :objects

  def initialize(model_name)
    begin
      model_class = model_name.constantize
      objects = model_class.all
    rescue
      puts 'Please provide a valid model name (e.g. `rake promethee:upgrade_structure[Page]`)'
      exit
    end
    @objects = objects
  end

  def start
    puts '= START STRUCTURE UPGRADE ='
    puts "Number of objects: #{objects.count}"
    i = 0
    objects.each do |object|
      next unless can_process?(object.data)
      i += 1
      process_object(object)
    end
    puts "Number of processed objects: #{i}"
    puts '====== END UPGRADER ========'
  end

  def process_object(object)
    puts "Processing object ##{object.id}"

    object.data = object.data.has_key?('components')  ? process_localization(object.data)
                                                      : process_component(object.data)
    object.save
    puts "End processing object ##{object.id}"
  end

  def process_localization(data)
    data['components'].map! { |component|
      process_localization_component(component)
    }.compact!

    # We remove the possible children to concatenate them to the list
    children = []
    data['components'].each { |component|
      children.concat component.delete('children').to_a
    }
    data['components'].concat(children).compact!

    data
  end

  def process_localization_component(component)
    upgraded_component = process_component(component)
    return nil if upgraded_component.nil?
    # We only keep the translatable attributes
    upgraded_component['attributes'].keep_if { |key, object_value| object_value['translatable'] }
    upgraded_component
  end

  def process_component(data)
    return nil unless data.has_key? 'type'

    component_type = data['type']
    component_upgrader = search_component(component_type).new(data)

    data = component_upgrader.upgraded_data
    data['children'] ||= []
    data['children'].map! { |child| process_component(child) }.compact!

    data
  end

  protected

  def can_process?(data)
    data.is_a?(Hash) && (data.has_key?("components") || data.has_key?("children"))
  end

  def search_component(type)
    component = components_library[type.to_sym]

    puts "Component <#{type}> not found." if component.nil?
    component
  end

  def components_library
    @components_library ||= BASE_COMPONENTS.merge(custom_components)
  end

  def custom_components
    # Overriden in derivated services
    {}
  end
end