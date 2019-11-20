# Row Component
# ================
#
# V3
# -----
#
# {
#   bgcolor: "rgba(255,255,255,0)",
#   backgrounds: []
# }
#

module Promethee::StructureUpgrader::Components
  class Row < Base
    def upgraded_attributes
      {
        'bgcolor' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'color',
          'value' => attribute('bgcolor'),
        },
        'backgrounds' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'array',
          'value' => attribute('backgrounds')
        }
      }
    end
  end
end