module PrometheeData
  extend ActiveSupport::Concern

  # Setter to serialize data as JSON
  def data=(value)
    value = JSON.parse value if value.is_a? String
    super(value)
  end

  # Getters and setters to get PAGE Title, Description & Thumbnail
  def promethee_data_page_title
    data['attributes']['searchable_title']
  rescue
    ''
  end

  def promethee_data_page_title=(value)
    self.data['attributes']['searchable_title'] = value
  end

  def promethee_data_page_description
    data['attributes']['searchable_description']
  rescue
    ''
  end

  def promethee_data_page_description=(value)
    self.data['attributes']['searchable_description'] = value
  end

  def promethee_data_page_thumbnail
    blob_id = data['attributes']['thumbnail']['id']
    if blob_id.is_a? String
      ActiveStorage::Blob.find_signed(blob_id) rescue nil
    else
      ActiveStorage::Blob.find(blob_id)
    end
  rescue
    nil
  end

  # Getters to get TRANSLATION Title & Description
  def promethee_data_translation_title
    data['components'].first['attributes']['searchable_title']
  rescue
    ''
  end

  def promethee_data_translation_description
    data['components'].first['attributes']['searchable_description']
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
end
