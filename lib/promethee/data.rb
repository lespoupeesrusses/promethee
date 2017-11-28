# The data class can be used for any level: the page, or one of the components
module Promethee
  class Data
    def initialize(data, options = {})
      @master_data = convert_if_necessary data
      @master_data_unlocalized = @master_data.clone
      localization_data = options[:localization_data]
      unless localization_data.nil?
        @localization_data = convert_if_necessary localization_data
        localize!
      end
    end

    def localization_data_to_json
      prepare_localization
      @localization_data.to_json
    end

    def to_json
      @master_data.to_json
    end

    def to_h
      @master_data
    end

    protected

    def convert_if_necessary(string_or_hash)
      string_or_hash.is_a?(String) ? JSON.parse(string_or_hash, symbolize_names: true) : string_or_hash
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

    def prepare_localization
      # TODO extract localizable components from master data, in the correct order, merged with existing ones
      # TODO update master_version
    end
  end
end
