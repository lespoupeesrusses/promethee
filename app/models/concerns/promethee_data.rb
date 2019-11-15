module PrometheeData
  extend ActiveSupport::Concern

  # Setter to serialize data as JSON
  def data=(value)
    value = JSON.parse value if value.is_a? String
    value = promethee_sanitize(value)
    super(value)
  end

  # Getters and setters to get PAGE Title, Description & Thumbnail
  def promethee_data_page_title
    data['attributes']['title']['value']
  rescue
    ''
  end

  def promethee_data_page_title=(value)
    self.data['attributes']['title']['value'] = value
  end

  def promethee_data_page_description
    data['attributes']['description']['description']
  rescue
    ''
  end

  def promethee_data_page_description=(value)
    self.data['attributes']['description']['value'] = value
  end

  def promethee_data_page_thumbnail
    ActiveStorage::Blob.find_signed(data['attributes']['thumbnail']['value']['id'])
  rescue
    nil
  end

  # Getters to get TRANSLATION Title & Description
  def promethee_data_translation_title
    data['components'].first['attributes']['title']['value']
  rescue
    ''
  end

  def promethee_data_translation_description
    data['components'].first['attributes']['description']['value']
  rescue
    ''
  end


  def promethee_data_searchable
    promethee_extract_searchable data
  end

  protected

  include ActionView::Helpers::SanitizeHelper

  def promethee_extract_searchable(component)
    # TODO: refactor
    return '' if component.blank?
    searchable = ' '
    searchable += promethee_extract_searchable_attributes component['attributes'] if component.include?('attributes')
    # For masters, contents are in children
    searchable += promethee_extract_searchable_children component['children'] if component.include? 'children'
    # For translations, contents are in components, not children
    searchable += promethee_extract_searchable_children component['components'] if component.include? 'components'
    searchable
  end

  def promethee_extract_searchable_attributes(attributes)
    searchable = ' '
    attributes.each do |key, value|
      if key.starts_with? 'searchable_'
        clean_value = strip_tags value
        searchable += "#{clean_value} "
      elsif value.class == Hash
        searchable += promethee_extract_searchable_attributes(value)
      end
    end
    searchable
  end

  def promethee_extract_searchable_children(components)
    searchable = ' '
    components.each do |child|
      searchable += promethee_extract_searchable child
    end
    searchable
  end

  def promethee_sanitize(data)
    attributes = data['attributes']
    attributes.each do |key, value_object|
      if value_object['type'] == 'string'
        while value_object['value'] != Loofah.fragment(value_object['value']).text(encode_special_chars: false)
          value_object['value'] = Loofah.fragment(value_object['value']).text(encode_special_chars: false)
        end
      elsif value_object['type'] == 'text'
        value_object['value'] = sanitize(value_object['value'])
      end
      attributes[key] = value_object
    end

    children = data['children']
    children.each do |child|
      child = promethee_sanitize(child)
    end unless children.nil?

    data
  end
end
