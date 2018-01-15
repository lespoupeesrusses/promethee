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

class Localization < ApplicationRecord
  belongs_to :page

  def to_s
    "Localization #{id}"
  end
end
