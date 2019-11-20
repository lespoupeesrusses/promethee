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
  # 2 substitute what's already localized, based on the component id
  # Consequences of step 1 are:
  # 1 it adds new components from the master
  # 2 it removes components not in the master anymore
  # 3 it takes the order from the master
  def merge
    @data_before_merge = @data.deep_dup
    @data = {
      version: @master_data[:version],
      components: []
    }
    @master_data.flat.each do |master_component|
      localized_component = find_localized_component master_component[:id]
      # We take the localized component if it exists, the master component otherwise
      component = localized_component || get_component_without_attributes_values(master_component)
      component[:attributes] ||= {}
      # We add it to the list of localized components
      @data[:components] << component
    end
  end

  def get_component_without_attributes_values(component)
    clean_component = component.deep_dup
    clean_component[:attributes] = clean_component[:attributes].keep_if { |key, object_value|
      object_value[:translatable]
    }.map { |key, object_value|
      [key, object_value.merge({ value: '' })]
    }.to_h

    clean_component
  end

  def find_localized_component(id)
    return unless @data_before_merge
    return unless @data_before_merge.include? :components
    @data_before_merge[:components].find { |component| component[:id] == id }
  end
end
