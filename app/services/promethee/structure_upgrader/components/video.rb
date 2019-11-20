# Video  Component
# ================
#
# V3
# -----
#
# {
#   url: 'https://vimeo.com/115082758',
#   autoplay: false
# }
#

module Promethee::StructureUpgrader::Components
  class Video < Base
    def upgraded_attributes
      {
        'url' => {
          'searchable' => false,
          'translatable' => true,
          'type' => 'string',
          'value' => string_attribute('url')
        },
        'autoplay' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'boolean',
          'value' => attribute('autoplay')
        }
      }
    end
  end
end