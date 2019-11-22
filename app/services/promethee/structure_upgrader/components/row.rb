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
          'value' => upgraded_backgrounds(attribute('backgrounds'))
        }
      }
    end

    private

    def upgraded_backgrounds(backgrounds)
      backgrounds.map { |background|
        {
          'image' => {
            'searchable' => false,
            'type' => 'blob',
            'value' => background['image']
          },
          'posh' => {
            'collection' => [
              { 'label' => 'Left', 'value' => 'left' },
              { 'label' => 'Center', 'value' => 'center' },
              { 'label' => 'Right', 'value' => 'right' }
            ],
            'searchable' => false,
            'type' => 'enum',
            'value' => background['posh']
          },
          'posv' => {
            'collection' => [
              { 'label' => 'Top', 'value' => 'top' },
              { 'label' => 'Center', 'value' => 'center' },
              { 'label' => 'Bottom', 'value' => 'bottom' }
            ],
            'searchable' => false,
            'type' => 'enum',
            'value' => background['posv']
          },
          'size' => {
            'collection' => [
              { 'label' => 'Auto', 'value' => 'auto' },
              { 'label' => 'Cover', 'value' => 'cover' },
              { 'label' => 'Contain', 'value' => 'contain' }
            ],
            'searchable' => false,
            'type' => 'enum',
            'value' => background['size']
          }
        }
      }
    end
  end
end