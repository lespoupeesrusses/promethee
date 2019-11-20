# Blockquote Component
# ================
#
# V3
# -----
#
# {
#   searchable_body: '<p>Edit me</p>',
#   searchable_author: ''
# }
#

module Promethee::StructureUpgrader::Components
  class Blockquote < Base
    def upgraded_attributes
      {
        'body' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'text',
          'value' => attribute('searchable_body'),
        },
        'author' => {
          'searchable' => true,
          'translatable' => false,
          'type' => 'string',
          'value' => string_attribute('searchable_author')
        }
      }
    end
  end
end