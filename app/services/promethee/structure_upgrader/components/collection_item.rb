# Collection Item Component
# ================
#
# V3
# -----
#
# {
#   searchable_caption: "",
#   media_type: "image",
#   image: {
#     id: undefined,
#     name: ""
#   },
#   video: {
#     url: "https://vimeo.com/115082758"
#   }
# }
#

module Promethee::StructureUpgrader::Components
  class CollectionItem < Base
    def upgraded_attributes
      {
        'caption' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'text',
          'value' => attribute('searchable_caption')
        },
        'media_type' => {
          'collection' => [
            { 'label' => 'Image', 'value' => 'image' },
            { 'label' => 'Video', 'value' => 'video' }
          ],
          'searchable' => false,
          'translatable' => false,
          'type' => 'enum',
          'value' => attribute('media_type')
        },
        'image' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'blob',
          'value' => attribute('image')
        },
        'video' => {
          'searchable' => false,
          'translatable' => true,
          'type' => 'video',
          'value' => attribute('video', 'url')
        }
      }
    end
  end
end