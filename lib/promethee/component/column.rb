class Promethee::Component::Column < Promethee::Component::Base
  has_attributes do |a|
    a.integer :size, default: 4
    a.integer :offset, default: 0
  end

  has_children :row, :text, :image, :video
end
