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
      text_matrix = []

      text_matrix << cols.map { |col_uid|
        string_attribute('cols_data', col_uid, 'searchable_text')
      }

      rows.each do |row_uid|
        text_matrix << cols.map { |col_uid|
          string_attribute('rows_data', row_uid, col_uid, 'searchable_text')
        }
      end

      @cell_matrix = text_matrix.map { |row|
        row.map { |cell_text| new_cell(cell_text) }
      }
    end

    def new_cell(text)
      {
        'id' => new_uuid,
        'type' => 'table_cell',
        'attributes' => {
          'text' => {
            'searchable' => true,
            'translatable' => true,
            'type' => 'string',
            'value' => text
          }
        }
      }
    end

    def new_uuid
      "#{uuid_s4}#{uuid_s4}-#{uuid_s4}-#{uuid_s4}-#{uuid_s4}-#{uuid_s4}#{uuid_s4}#{uuid_s4}"
    end

    def uuid_s4
      # https://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript
      ((1 + rand) * 0x10000).floor.to_s(16)[1..-1];
    end
  end
end