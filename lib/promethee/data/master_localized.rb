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
    localize_component_attributes component
    localize_component_children component
  end

  def localize_component_attributes(component)
    return unless component.include? :attributes
    localized_component = find_localized_component component[:id]
    return unless localized_component
    return unless localized_component.include? :attributes
    component[:attributes].merge! localized_component[:attributes]
  end

  def localize_component_children(component)
    return unless component.include? :children
    component[:children].each { |child| localize_component child }
  end

  def find_localized_component(id)
    return if @localization.nil?
    return unless @localization.include? :components
    @localization[:components].find { |component| component[:id] == id }
  end
end