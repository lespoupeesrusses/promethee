module Promethee
  class BlobUpgradeService
    attr_accessor :objects

    def initialize(model_name)
      begin
        model_class = model_name.constantize
        objects = model_class.all
      rescue
        puts 'Please provide a valid model name (e.g. `rake promethee:upgrade_blob_data[Page]`)'
        exit
      end
      @objects = objects
    end

    def start
      puts '= START BLOB UPGRADE ='
      puts "Number of objects: #{@objects.count}"
      @objects.each do |object|
        puts "Processing object ##{object.id}"

        if object.data.nil?
          puts "End processing object ##{object.id}: no data"
        else
          object.data = upgrade_component(object.data.deep_symbolize_keys)
          object.save
          puts "End processing object ##{object.id}"
        end
      end
      puts '====== END UPGRADER ========'
    end

    private

    def upgrade_component(component)
      component[:attributes] = upgrade_attribute(component[:attributes]) unless component[:attributes].nil?
      component[:children].map { |child_component|
        upgrade_component(child_component)
      } unless component[:children].nil?

      component
    end

    def upgrade_attribute(attribute_value)
      return upgrade_blob_data(attribute_value) if is_blob_data?(attribute_value)

      if attribute_value.is_a? Array
        attribute_value.map { |item| upgrade_attribute(item) }
      elsif attribute_value.is_a? Hash
        attribute_value.map { |key, value| [key, upgrade_attribute(value)] }.to_h
      else
        attribute_value
      end
    end

    def upgrade_blob_data(blob_data)
      new_blob_data = blob_data.dup
      blob_id = new_blob_data[:id]
      return new_blob_data unless blob_id.present? && blob_id.is_a?(Integer)

      blob = ActiveStorage::Blob.find_by(id: blob_id)
      new_blob_data[:id] = blob.signed_id unless blob.nil?

      new_blob_data
    end

    def is_blob_data?(hash)
      hash.is_a?(Hash) && hash.keys == [:id, :name]
    end
  end
end
