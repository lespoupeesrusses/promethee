# Cover Component
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
#   searchable_surtitle: '',
#   searchable_title: '',
#   searchable_subtitle: ''
# }
#

module Promethee::StructureUpgrader::Components
  class Cover < Base
    def upgraded_attributes
      {
        'image' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'blob',
          'value' => attribute('image')
        },
        'surtitle' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'string',
          'value' => string_attribute('searchable_surtitle')
        },
        'title' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'string',
          'value' => string_attribute('searchable_title')
        },
        'subtitle' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'string',
          'value' => string_attribute('searchable_subtitle')
        }
      }
    end
  end
end