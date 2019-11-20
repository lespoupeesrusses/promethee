# Page Component
# ================
#
# V3
# -----
#
# {
#   searchable_title: 'New page',
#   searchable_description: '',
#   thumbnail: {
#     id: undefined,
#     name: ''
#   },
#   stylesheets: '',
#   javascripts: ''
# }
#

module Promethee::StructureUpgrader::Components
  class Page < Base
    def upgraded_attributes
      {
        'title' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'string',
          'value' => string_attribute('searchable_title')
        },
        'description' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'text',
          'value' => attribute('searchable_description')
        },
        'thumbnail' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'blob',
          'value' => attribute('thumbnail')
        },
        'stylesheets' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'string',
          'value' => string_attribute('stylesheets')
        },
        'javascripts' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'string',
          'value' => string_attribute('javascripts')
        }
      }
    end
  end
end