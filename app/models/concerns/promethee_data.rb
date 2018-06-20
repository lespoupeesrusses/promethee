module PrometheeData
  extend ActiveSupport::Concern

  # Setter to serialize data as JSON
  def data=(value)
    value = JSON.parse value if value.is_a? String
    super(value)
  end

  # Getters and setters to get PAGE Title & Description
  def promethee_data_page_title
    data['attributes']['searchable_title']
  rescue
    ""
  end

  def promethee_data_page_title=(value)
    self.data['attributes']['searchable_title'] = value
  end

  def promethee_data_page_description
    data['attributes']['searchable_description']
  rescue
    ""
  end

  def promethee_data_page_description=(value)
    self.data['attributes']['searchable_description'] = value
  end

  # Getters to get TRANSLATION Title & Description
  def promethee_data_translation_title
    data['components'].first['attributes']['searchable_title']
  rescue
    ""
  end

  def promethee_data_translation_description
    data['components'].first['attributes']['searchable_description']
  rescue
    ""
  end


  def promethee_data_searchable
    promethee_extract_searchable data
  end

  protected

  include ActionView::Helpers::SanitizeHelper
  def promethee_extract_searchable(component)
    return '' if component.blank?
    searchable = ' '
    component['attributes'].each do |key, value|
      if key.starts_with? 'searchable_'
        clean_value = strip_tags value
        searchable += "#{clean_value} "
      end
    end if component.include? 'attributes'
    component['children'].each do |child|
      searchable += promethee_extract_searchable child
    end if component.include? 'children'
    # for translations
    component['components'].each do |child|
      searchable += promethee_extract_searchable child
    end if component.include? 'components'
    searchable
  end
end
