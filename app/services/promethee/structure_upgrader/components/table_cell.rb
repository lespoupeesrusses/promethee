# Table Cell Component
# ================
#
# V3
# -----
#
# Did not exist
#

module Promethee::StructureUpgrader::Components
  class TableCell < Base
    def upgraded_attributes
      @data['attributes']
    end
  end
end