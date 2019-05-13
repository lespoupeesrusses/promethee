class Promethee::LocalizeCleanService
  self.DEFAULT_WHITELIST = {
    aside:            [:searchable_visible_content, :searchable_collapsed_content, :searchable_open_label],
    blockquote:       [:searchable_body, :searchable_author],
    collection:       [],
    collection_item:  [:searchable_caption, :video],
    column:           [],
    cover:            [:searchable_surtitle, :searchable_title, :searchable_subtitle],
    faq:              [],
    faq_item:         [:searchable_title, :searchable_body],
    image:            [:searchable_alt, :searchable_caption],
    page:             [:searchable_title, :searchable_description],
    row:              [],
    slider:           [],
    slider_item:      [:searchable_caption, :video],
    table:            [:cols, :cols_data, :rows, :rows_data],
    text:             [:searchable_body],
    video:            [:url]
  }

  attr_accessor :objects

  def initialize(objects, whitelist = {})
    @objects = objects
    @whitelist = self.DEFAULT_WHITELIST.merge(whitelist)
  end

  def add_type(type, attributes = [])
    @whitelist[type] = attributes
  end

  def start
    puts '= START LOCALIZE CLEAN ='
    puts "Number of objects: #{objects.count}"
    objects.each do |object|
      next if object.data.nil? || object.data == '{}'

      object.data = clean(object.data)
      object.save
    end
    puts '====== END CLEANER ========'
  end

  private

  def clean(data)
    i = 0
    data.each do |component|
      component_whitelist = component[:type]
      next if component_whitelist.nil? # Process only types in whitelist

      i += 1
      component[:attributes].slice!(*component_whitelist)
    end
    puts ""
    data
  end

end