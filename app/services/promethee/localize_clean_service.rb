module Promethee
  class LocalizeCleanService
    DEFAULT_WHITELIST = {
      "aside"            => ["searchable_visible_content", "searchable_collapsed_content", "searchable_open_label"],
      "blockquote"       => ["searchable_body", "searchable_author"],
      "collection"       => [],
      "collection_item"  => ["searchable_caption", "video"],
      "column"           => [],
      "cover"            => ["searchable_surtitle", "searchable_title", "searchable_subtitle"],
      "faq"              => [],
      "faq_item"         => ["searchable_title", "searchable_body"],
      "image"            => ["searchable_alt", "searchable_caption"],
      "page"             => ["searchable_title", "searchable_description"],
      "row"              => [],
      "slider"           => [],
      "slider_item"      => ["searchable_caption", "video"],
      "table"            => ["cols", "cols_data", "rows", "rows_data"],
      "text"             => ["searchable_body"],
      "video"            => ["url"]
    }

    attr_accessor :objects

    def initialize(model_name, whitelist = {})
      begin
        model_class = model_name.constantize
        objects = model_class.all
      rescue
        puts 'Please provide a valid model name (e.g. `rake promethee:clean_localizations[Page]`)'
        exit
      end
      @objects = objects
      @whitelist = DEFAULT_WHITELIST.merge(whitelist)
    end

    def add_rule(type, attributes = [])
      @whitelist[type] = attributes
    end

    def start
      puts '= START LOCALIZE CLEAN ='
      puts "Number of objects: #{objects.count}"
      i = 0
      objects.each do |object|
        next unless can_process?(object.data)

        i += 1
        puts "Processing object ##{object.id}"

        object.data = clean(object.data)
        object.save
        puts "End processing object ##{object.id}"
      end
      puts "Number of processed objects: #{i}"
      puts '====== END CLEANER ========'
    end

    private

    def clean(data)
      i = 0
      data["components"].each do |component|
        component_whitelist = @whitelist[component["type"]]
        next if component_whitelist.nil? # Process only types in whitelist

        i += 1
        component["attributes"]&.slice!(*component_whitelist)
      end
      puts "- #{i} components were processed"
      data
    end

    def can_process?(data)
      data.is_a?(Hash) && data.has_key?("components")
    end
  end
end