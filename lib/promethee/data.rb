# The data class can be used for any level: the page, or one of the components
module Promethee
  class Data
    def initialize(data, options = {})
      @master_data = hashify data
      @localization_data_raw = hashify options[:localization_data] if options.include? :localization_data
      prepare_localization_data
      localize_master_data
    end

    def localization_data_to_json
      @localization_data.to_json
    end

    def to_json
      @master_data.to_json
    end

    # The data acts as a hash
    def [](value)
      @master_data[value]
    end 

    protected

    def hashify(string_or_hash)
      string_or_hash.is_a?(String) ? JSON.parse(string_or_hash, symbolize_names: true) : string_or_hash
    end

    # We merge the localization data in the components from the master data.
    # This will :
    # 1 get what's already localized, based on the component id
    # 2 add new components
    # 3 remove components not in the master anymore
    # 4 take the order from the master
    def prepare_localization_data
      @localization_data = {
        version: @master_data[:version],
        components: []
      }
      # We create a flat list of the children and all their child, in the master's order
      master_components_flat = Promethee::Data.flatten_components @master_data.deep_dup[:children]
      master_components_flat.each do |component|
        localized_component = Promethee::Data.find_localized_component component[:id], @localization_data_raw
        # We take either the localized, or the master component
        data = localized_component || component
        # We add master reference
        data[:master] = component.deep_dup
        # We add it to the list of localized components
        @localization_data[:components] << data
      end
    end

    # Recursively merge the localization_data into the master_data
    def localize_master_data
      Promethee::Data.localize_component @master_data, @localization_data
    end

    def self.find_localized_component(id, array)
      return nil if array.nil?
      return nil unless array.include? :components
      array[:components].select { |component| component[:id] == id }.first
    end

    def self.localize_component(component, localization_data)
      if component.include? :attributes
        localized_component = Promethee::Data.find_localized_component component[:id], localization_data
        component[:attributes].merge! localized_component[:attributes] unless localized_component.nil?
      end
      component[:children].each { |child| localize_component child, localization_data } if component.include? :children
    end

    # Takes an array of components and puts every component and their children into a unique flat array
    def self.flatten_components(components)
      return [] if components.nil?
      components.reduce [] do |flat_components, component|
        flat_components +
        [component.except(:children)] +
        flatten_components(component[:children] || [])
      end
    end
  end
end