# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ApplicationRecord
  has_many :localizations
  
  def to_s
    "#{title.blank? ? 'Untitled page' : title}"
  end
end
