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
      @upgraded_data = @data.deep_dup
      return if @upgraded_data['attributes'].empty?

      attribute('cols').nil?  ? generate_cell_matrix_from_data
                              : generate_cell_matrix_from_structure

      @upgraded_data['attributes'] = upgraded_attributes.deep_stringify_keys
      @upgraded_data['children'] = @cell_matrix.flatten
    end

    def upgraded_attributes
      uuid_matrix = @cell_matrix.map { |row| row.map { |cell| cell['id'] } }

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

    def generate_cell_matrix_from_structure
      cols = attribute('cols').to_a
      rows = attribute('rows').to_a
      data_matrix = []

      data_matrix << cols.map { |col_uid| new_cell_data(:col, col_uid) }
      rows.each do |row_uid|
        data_matrix << cols.map { |col_uid| new_cell_data(:row, col_uid, row_uid) }
      end

      generate_cell_matrix(data_matrix)
    end

    def generate_cell_matrix_from_data
      cols_data = attribute('cols_data').to_h
      rows_data = attribute('rows_data').to_h
      data_matrix = []

      data_matrix << cols_data.map { |col_uid, _| new_cell_data(:col, col_uid) }
      rows_data.each do |row_uid, row_data|
        data_matrix << row_data.map { |col_uid, _| new_cell_data(:row, col_uid, row_uid) }
      end

      generate_cell_matrix(data_matrix)
    end

    def new_cell_data(type, col_uid, row_uid = nil)
      row_uid ||= col_uid
      uids = [row_uid, col_uid]

      text = type == :col ? string_attribute('cols_data', col_uid, 'searchable_text')
                          : string_attribute('rows_data', *uids, 'searchable_text')

      { text: text, uids: uids }
    end

    def generate_cell_matrix(data_matrix)
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