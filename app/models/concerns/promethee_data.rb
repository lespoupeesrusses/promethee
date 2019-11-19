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
    data['attributes']['description']['value']
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
    return '' if component.blank?
    searchable = ' '
    searchable += promethee_extract_searchable_attributes component['attributes'] if component.include?('attributes')
    # For masters, contents are in children
    searchable += promethee_extract_searchable_children component['children'] if component.include?('children')
    # For translations, contents are in components, not children
    # TODO: children
    # searchable += promethee_extract_searchable_children component['components'] if component.include? 'components'
    searchable
  end

  def promethee_extract_searchable_attributes(attributes)
    searchable = ' '
    attributes.each do |key, value_object|
      if value_object['searchable']
        clean_value = strip_tags value_object['value']
        searchable += "#{clean_value} "
      end
      if value_object['type'] == 'array'
        value_object['value'].each do |object|
          searchable += promethee_extract_searchable_attributes(object)
        end
      elsif value_object['type'] == 'hash'
        searchable += promethee_extract_searchable_attributes(value_object['value'])
      end
    end
    searchable
  end

  def promethee_extract_searchable_children(components)
    # TODO
    searchable = ' '
    components.each do |child|
      searchable += promethee_extract_searchable child
    end
    searchable
  end

  def promethee_sanitize(component)
    attributes = component['attributes']
    attributes = promethee_sanitize_attributes(attributes)

    children = component['children']
    children.each do |child|
      child = promethee_sanitize(child)
    end unless children.nil?

    component
  end

  def promethee_sanitize_attributes(attributes)
    attributes.each do |key, value_object|
      case value_object['type']
      when 'string'
        while value_object['value'] != Loofah.fragment(value_object['value']).text(encode_special_chars: false)
          value_object['value'] = Loofah.fragment(value_object['value']).text(encode_special_chars: false)
        end
      when 'text'
        value_object['value'] = sanitize(value_object['value'])
      when 'hash'
        value_object['value'] = promethee_sanitize_attributes(value_object['value'])
      when 'array'
        value_object['value'].each do |object|
          object = promethee_sanitize_attributes(object)
        end
      end if value_object.has_key?('type')
      attributes[key] = value_object
    end unless attributes.nil?
    attributes
  end
end
