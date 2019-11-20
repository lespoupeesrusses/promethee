# Image Component
# ================
#
# V3
# -----
#
# {
#   image: {
#     id: undefined,
#     name: ''
#   },
#   searchable_alt: '',
#   searchable_caption: ''
# }
#

module Promethee::StructureUpgrader::Components
  class Image < Base
    def upgraded_attributes
      {
        'image' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'blob',
          value: attribute('image')
        },
        'alt' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'string',
          'value' => string_attribute('searchable_alt')
        },
        'caption' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'string',
          'value' => string_attribute('searchable_caption')
        }
      }
    end
  end
end