module PrometheeData
  extend ActiveSupport::Concern

  def data_page_title
    data['attributes']['searchable_title']
  end

  def data_page_description
    data['attributes']['searchable_description']
  end

  def data=(value)
    value = JSON.parse value if value.is_a? String
    super(value)
  end

  def promethee_data_searchable
    promethee_extract_searchable data
  end

  protected

  include ActionView::Helpers::SanitizeHelper
  def promethee_extract_searchable(component)
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
    end if component.include? 'children'
    searchable
  end
end
