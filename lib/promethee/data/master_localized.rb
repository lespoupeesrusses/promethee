# Injects localization data into master data, so the page can be showed in the correct localization
class Promethee::Data::MasterLocalized < Promethee::Data
  def initialize(master, localization = nil)
    @data = hashify master
    if localization
      @localization = Localization.new localization
      localize_component @data
    end
  end

  protected

  def localize_component(component)
    localize_component_attributes component if component.include?(:attributes)
    localize_component_children component if component.include?(:children)
  end

  def localize_component_attributes(component)
    localized_component = find_localized_component component[:id]
    return if (localized_component.nil? || !localized_component.include?(:attributes))
    component[:attributes].deep_merge_existing_keys! localized_component[:attributes]
  end



  def localize_component_children(component)
    component[:children].each { |child| localize_component child }
  end

  def find_localized_component(id)
    return if @localization.nil? || !@localization.include?(:components)
    @localization[:components].find { |component| component[:id] == id }
  end
end