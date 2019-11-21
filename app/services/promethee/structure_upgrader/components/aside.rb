# Aside Component
# ================
#
# V3
# -----
#
# {
#   searchable_visible_content: '<p>Edit me</p>',
#   searchable_collapsed_content: '',
#   searchable_open_label: 'See more',
#   open_label_position: 'left'
# }
#

module Promethee::StructureUpgrader::Components
  class Aside < Base
    def upgraded_attributes
      {
        'visible_content' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'text',
          'value' => attribute('searchable_visible_content')
        },
        'collapsed_content' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'text',
          'value' => attribute('searchable_collapsed_content')
        },
        'open_label' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'string',
          'value': string_attribute('searchable_open_label')
        },
        'open_label_position' => {
          'collection' => [
            { 'label' => 'Left', 'value' => 'left' },
            { 'label' => 'Center', 'value' => 'center' },
            { 'label' => 'Right', 'value' => 'right' }
          ],
          'searchable' => false,
          'translatable' => false,
          'type' => 'enum',
          'value' => attribute('open_label_position')
        }
      }
    end
  end
end