# The data class can be used for any level: the page, or one of the components
module Promethee
  class Data
    def initialize(data, options = {})
      @master_data = convert_if_necessary data
      @master_data_unlocalized = deep_clone @master_data
      localization_data = options[:localization_data]
      unless localization_data.nil?
        @localization_data = convert_if_necessary localization_data
        localize!
      end
    end

    def localization_data
      prepare_localization
      @localization_data
    end

    def localization_data_to_json
      localization_data.to_json
    end

    def to_json
      @master_data.to_json
    end

    def to_h
      @master_data
    end

    protected

    def convert_if_necessary(string_or_hash_or_anything)
      # string_or_hash_or_anything could be a string a hash or anything so we need to handle potential exception to keep this method safe
      begin
        converted = string_or_hash_or_anything.is_a?(String) ? JSON.parse(string_or_hash_or_anything, symbolize_names: true) : string_or_hash_or_anything
      rescue
        converted = {}
      end

      # The parsed json could be anything: "\"hey\"" => "hey", "[\"hey\"]" => ["hey"], "null" => nil, ...
      converted = {} unless converted.is_a? Hash

      # The data might not be a json string so the "symbolize_names" options wouldn't do anything on a ruby hash because JSON.parse wouldn't be called
      converted.deep_symbolize_keys!

      # The children array is required in order to make this class work
      converted[:children] = [] unless converted[:children].is_a?(Array)

      # The type is required in order to make this class work
      converted[:type] = converted[:type].is_a?(String) || converted[:type].is_a?(Symbol) ? converted[:type].to_s : 'page'

      converted
    end

    def deep_clone(hash)
      JSON.parse(hash.to_json, symbolize_names: true)
    end

    # This will recursively merge the localization_data into the master_data
    def localize!
      merge!
      localize_children!
    end

    def merge!
      @master_data[:attributes].merge! localized_component[:attributes] if localized?
    end

    # Look for localized component with the same id
    def localized_component
      @localized_component ||= components.select { |component| component[:id] == @master_data[:id] }.first
    end

    def components
      @components ||= @localization_data.include?(:components) ? @localization_data[:components] : []
    end

    def localized?
      !localized_component.nil?
    end

    def localize_children!
      children.each do |child_hash|
        child_data = Promethee::Data.new child_hash, localization_data: @localization_data
        child_data.localize!
      end
    end

    def children
      return [] if !@master_data.include? :children or @master_data[:children].nil?
      @master_data[:children]
    end

    def flat_children
      self.class.flatten_components @master_data_unlocalized[:children]
    end

    def prepare_localization
      # TODO extract localizable components from master data, in the correct order, merged with existing ones
      # TODO update master_version

      # Selects only text components within the children components flat array
      # TODO think about a better way to handle localized attributes among all the components (not only text type)
      flat_master_data = flat_children.select { |component| component[:type].to_sym === :text }

      if @localization_data
        # If localization_data has been provided, we merge flat_master_data components with its components
        @localization_data[:components] = flat_master_data.map do |component|
          localized_component = @localization_data[:components].find do |localized_component|
            localized_component[:id] == component[:id]
          end

          # If the localized_component isn't found, we create it with the master (component)
          # Eventually, we add a reference to the master in the localized component
          (localized_component || component).merge master: component.deep_dup
        end
      else
        # In the other case, localization_data components are flat_master_data components
        @localization_data = {
          version: @master_data[:version],
          components: flat_master_data
        }
      end
    end

    # This method take an array of components and puts every components and their children into a unique flat array
    def self.flatten_components components
      components.reduce [] do |flat_components, component|
        flat_components +
        [component.except(:children)] +
        flatten_components(component[:children] || [])
      end
    end
  end
end
