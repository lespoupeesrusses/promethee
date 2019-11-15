class Promethee::StructureUpgrader::Mappings::Row
  def self.type_mappings
    {
      bgcolor: 'color',
      backgrounds: 'array'
    }
  end

  def self.items_type_mappings
    {
      backgrounds: {
        image: 'blob',
        posh: 'enum',
        posv: 'enum',
        size: 'enum'
      }
    }
  end

  def self.enums_collections
    {
      backgrounds: {
        posh: [
          { label: 'Left', value: 'left' },
          { label: 'Center', value: 'center' },
          { label: 'Right', value: 'right' }
        ],
        posv: [
          { label: 'Top', value: 'top' },
          { label: 'Center', value: 'center' },
          { label: 'Bottom', value: 'bottom' }
        ],
        size: [
          { label: 'Auto', value: 'auto' },
          { label: 'Cover', value: 'cover' },
          { label: 'Contain', value: 'contain' }
        ]
      }
    }
  end
end