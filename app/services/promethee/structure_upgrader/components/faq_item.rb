# Faq Item Component
# ================
#
# V3
# -----
#
# {
#   image: {
#     id: undefined,
#     name: ""
#   },
#   searchable_title: "",
#   searchable_body: "",
#   special_question: false
# }
#

module Promethee::StructureUpgrader::Components
  class FaqItem < Base
    def upgraded_attributes
      {
        'image' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'blob',
          'value' => attribute('image')
        },
        'title' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'string',
          'value': string_attribute('searchable_title')
        },
        'body' => {
          'searchable' => true,
          'translatable' => true,
          'type' => 'text',
          'value' => attribute('searchable_body')
        },
        'special_question' => {
          'searchable' => false,
          'translatable' => false,
          'type' => 'boolean',
          'value' => attribute('special_question')
        }
      }
    end
  end
end