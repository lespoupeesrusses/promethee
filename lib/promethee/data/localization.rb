class Promethee::Data::Localization < Promethee::Data
  def initialize(data, master_data = nil)
    super data
    if master_data
      @master_data = Master.new master_data
      merge
    end
  end

  protected

  # We want to be up to date with the master, so this method will:
  # 1.take the master's components flattened
  # 2 substitute values of what's already localized, based on the component id
  # Consequences of step 1 are:
  # 1 it adds new components from the master
  # 2 it removes components not in the master anymore
  # 3 it takes the order from the master
  # 4 use all translatable attributes from the master
  # 5 merge them with translation values if they exist
  def merge
    @data_before_merge = @data.deep_dup
    @data = {
      version: @master_data[:version],
      components: []
    }
    @master_data.flat.each do |master_component|
      translatable_master_component = get_component_without_attributes_values(master_component)
      localized_component = find_localized_component master_component[:id]

      component = get_merged_translatable_component(translatable_master_component, localized_component)
      @data[:components] << component
    end
  end

  def get_component_without_attributes_values(component)
    clean_component = component.deep_dup
    clean_component[:attributes] = clean_component[:attributes].keep_if { |key, object_value|
      object_value[:translatable]
    }.map { |key, object_value|
      [key, object_value.merge({ value: '' })]
    }.to_h if clean_component.has_key? :attributes

    clean_component
  end

  def get_merged_translatable_component(master_component, localized_component)
    # Not found in translation, we use the prepared master component
    return master_component if localized_component.nil?

    master_component[:attributes] ||= {}
    localized_component[:attributes] ||= {}

    # Merge values with the prepared master, allowing to add missing attributes from translation
    master_component[:attributes].each do |attr_key, attr_value|
      attr_value[:value] = localized_component.dig(:attributes, attr_key, :value) || ''
    end

    master_component
  end

  def find_localized_component(id)
    return unless @data_before_merge
    return unless @data_before_merge.include? :components
    @data_before_merge[:components].find { |component| component[:id] == id }
  end
end
