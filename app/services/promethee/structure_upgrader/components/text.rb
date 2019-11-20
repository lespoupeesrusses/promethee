# Text Component
# ================
#
# V3
# -----
#
# {
#   searchable_body: '<p>Edit me</p>'
# }
#

module Promethee::StructureUpgrader::Components
  class Text < Base
    def upgraded_attributes
      {
        'body' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'text',
          'value' => attribute('searchable_body')
        }
      }
    end
  end
end