module Promethee
  class TableUpgradeService
    attr_accessor :objects

    def initialize(model_name)
      begin
        model_class = model_name.constantize
        objects = model_class.all.select { |page| page.data&.to_json&.include? '"type":"table"' }
      rescue
        puts 'Please provide a valid model name (e.g. `rake promethee:upgrade_table[Page]`)'
        exit
      end
      @objects = objects
    end

    def start
      puts '= START TABLE UPGRADE ='
      puts "Number of objects: #{objects.count}"
      objects.each do |object|
        puts "Processing object ##{object.id}"

        object.data = process_component(object.data)
        object.save
        puts "End processing object ##{object.id}"
      end
      puts '====== END UPGRADER ========'
    end

    private

    def process_component(component)
      component = upgrade(component) if component["type"] == "table"
      component["children"].map do |child|
        process_component(child)
      end if component["children"]&.any?
      component
    end

    def upgrade(component)
      return component unless component.has_key? "attributes"

      head = component["attributes"]["head"]
      body = component["attributes"]["body"]
      return component if head.nil? || body.nil?

      cols = create_uids(head)
      rows = create_uids(body)

      cols_data = head.map.with_index { |col_data, i| [cols[i], col_data] }.to_h
      rows_data = body.map.with_index { |row_data, i|
        new_row_data = row_data.map.with_index { |cell_data, j| [cols[j], cell_data] }.to_h
        [rows[i], new_row_data]
      }.to_h

      component["attributes"].except!("head", "body")

      component["attributes"]["cols"] = cols
      component["attributes"]["cols_data"] = cols_data
      component["attributes"]["rows"] = rows
      component["attributes"]["rows_data"] = rows_data

      component
    end

    def create_uids(array)
      (0...array.size).map { |_| SecureRandom.hex(5) }
    end
  end
end