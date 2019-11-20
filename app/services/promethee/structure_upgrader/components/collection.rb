# Collection Component
# ================
#
# V3
# -----
#
# {
#   items_per_line: 6
# }
#

module Promethee::StructureUpgrader::Components
  class Collection < Base
    def upgraded_attributes
      {
        'items_per_line' => {
          'collection' => [
            { 'label' => '2', 'value' => 2 },
            { 'label' => '3', 'value' => 3 },
            { 'label' => '4', 'value' => 4 },
            { 'label' => '6', 'value' => 6 }
          ],
          'searchable' => false,
          'translatable' => false,
          'type' => 'enum',
          'value' => attribute('items_per_line')
        }
      }
    end
  end
end