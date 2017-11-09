class Page < ApplicationRecord
  def to_s
    "#{title}"
  end
end
