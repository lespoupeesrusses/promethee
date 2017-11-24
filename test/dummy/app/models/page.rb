class Page < ApplicationRecord
  def to_s
    "#{title.blank? ? 'Untitled page' : title}"
  end
end
