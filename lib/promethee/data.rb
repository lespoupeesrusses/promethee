# The data class can be used for any level: the page, or one of the components
module Promethee
  class Data
    def initialize(data, options = {})
      @master_data = hashify data
      @localization_data_raw = hashify(options[:localization_data]) if options.include? :localization_data
      @other_data = hashify(options[:other_data]) if options.include? :other_data
      check_master_integrity
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

    def hashify(data)
      # https://github.com/bbatsov/ruby-style-guide#indent-conditional-assignment
      h = case data.class.to_s
          when 'Hash', 'ActiveSupport::HashWithIndifferentAccess' then data
          when 'String' then JSON.parse data
          else {}
          end

      h.deep_symbolize_keys
    end

    def check_master_integrity
      @master_data[:version] = 1 unless @master_data.include? :version
      @master_data[:children] = [] unless @master_data.include? :children
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
      master_components_flat.each do |master_component|
        localized_component = find_localized_component master_component[:id]
        # We take the localized component if it exists, the master component otherwise
        data = localized_component || master_component
        # We add master reference
        data[:master] = master_component.deep_dup
        # We add localized component in other languages
        data[:other] = add_other_data_for master_component[:id]
        # We add it to the list of localized components
        @localization_data[:components] << data
      end
    end

    def add_other_data_for(component_id)
      hash = {}
      return hash if @other_data.nil?
      @other_data.each do |other_key, other_value|
        localized_component = find_localized_component_in_array component_id, other_value
        hash[other_key] = localized_component if localized_component
      end
      hash
    end

    # We create a flat list of the children and all their child, in the master's order
    def master_components_flat
      Promethee::Data.flatten_components @master_data.deep_dup
    end

    def find_localized_component(id)
      find_localized_component_in_array id, @localization_data_raw
    end

    def find_localized_component_in_array(id, array)
      Promethee::Data.find_localized_component id, array
    end

    # Recursively merge the localization_data into the master_data
    def localize_master_data
      Promethee::Data.localize_component @master_data, @localization_data
    end

    def self.find_localized_component(id, array)
      return nil if array.nil?
      return nil unless array.include? :components
      array[:components].find { |component| component[:id] == id }
    end

    def self.localize_component(component, localization_data)
      localize_component_attributes component, localization_data
      localize_component_children component, localization_data
    end

    def self.localize_component_attributes(component, localization_data)
      return unless component.include? :attributes
      localized_component = Promethee::Data.find_localized_component component[:id], localization_data
      return if localized_component.nil?
      return unless localized_component.include? :attributes
      component[:attributes].merge! localized_component[:attributes]
    end

    def self.localize_component_children(component, localization_data)
      return unless component.include? :children
      component[:children].each { |child| localize_component child, localization_data }
    end

    # Takes an array of components and puts every component and their children into a unique flat array
    def self.flatten_components(component)
      flat_components = [component.except(:children)]
      (component[:children] || []).reduce flat_components do |flat_components, component|
        flat_components + flatten_components(component)
      end
    end
  end
end
