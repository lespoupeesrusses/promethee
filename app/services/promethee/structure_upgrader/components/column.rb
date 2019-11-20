# Column Component
# ================
#
# V3
# -----
#
# {
#   size: 4,
#   offset: 0,
#   mobile: {
#     enabled: false,
#     size: 12,
#     offset: 0
#   },
#   tablet: {
#     enabled: false,
#     size: 12,
#     offset: 0
#   }
# }
#

module Promethee::StructureUpgrader::Components
  class Column < Base
    def upgraded_attributes
      {
        'size' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'integer',
          'value' => attribute('size')
        },
        'offset' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'integer',
          'value' => attribute('offset')
        },
        'mobile' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'hash',
          'value' => {
            'enabled' => {
              'searchable' => false,
              'translatable' => false,
              'type' => 'boolean',
              'value' => attribute('mobile', 'enabled')
            },
            'size' => {
              'searchable' => false,
              'translatable' => false,
              'type' => 'integer',
              'value' => attribute('mobile', 'size')
            },
            'offset' => {
              'searchable' => false,
              'translatable' => false,
              'type' => 'integer',
              'value' => attribute('mobile', 'offset')
            }
          }
        },
        'tablet' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'hash',
          'value' => {
            'enabled' => {
              'searchable' => false,
              'translatable' => false,
              'type' => 'boolean',
              'value' => attribute('tablet', 'enabled')
            },
            'size' => {
              'searchable' => false,
              'translatable' => false,
              'type' => 'integer',
              'value' => attribute('tablet', 'size')
            },
            'offset' => {
              'searchable' => false,
              'translatable' => false,
              'type' => 'integer',
              'value' => attribute('tablet', 'offset')
            }
          }
        }
      }
    end
  end
end