# Table Component
# ================
#
# V3
# -----
#
# {
#   cols: [],
#   cols_data: {},
#   rows: [],
#   rows_data: {}
# }
#

module Promethee::StructureUpgrader::Components
  class Table < Base
    def upgrade
      generate_cell_matrix

      super
      @upgraded_data['children'] = @cell_matrix.flatten
    end

    def upgraded_attributes
      uuid_matrix = @cell_matrix.map { |row|
        row.map { |cell| cell['id'] }
      }

      {
        'structure' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'matrix',
          'value' => uuid_matrix
        }
      }
    end

    private

    def generate_cell_matrix
      cols = attribute('cols')
      rows = attribute('rows')
      data_matrix = []

      data_matrix << cols.map { |col_uid|
        {
          text: string_attribute('cols_data', col_uid, 'searchable_text'),
          uids: [col_uid, col_uid]
        }
      }

      rows.each do |row_uid|
        data_matrix << cols.map { |col_uid|
          {
            text: string_attribute('rows_data', row_uid, col_uid, 'searchable_text'),
            uids: [row_uid, col_uid]
          }
        }
      end

      @cell_matrix = data_matrix.map { |row|
        row.map { |cell_data| new_cell(cell_data) }
      }
    end

    def new_cell(data)
      {
        'id' => new_uuid(data[:uids]),
        'type' => 'table_cell',
        'attributes' => {
          'text' => {
            'searchable' => true,
            'translatable' => true,
            'type' => 'string',
            'value' => data[:text]
          }
        }
      }
    end

    def new_uuid(uids)
      # Not random to keep the connection between master & translations
      # [bf59b8868b, dcd302bc62]
      # => "bf59b886-8bdc-d302-bc62-8bdcd302bc62"
      source = uids.join ''
      parts = [
        source[0..7],
        source[8..11],
        source[12..15],
        source[16..19],
        source[8..19]
      ]

      parts.join('-')
    end
  end
end