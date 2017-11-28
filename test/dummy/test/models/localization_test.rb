# == Schema Information
#
# Table name: localizations
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  data       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LocalizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
