class Promethee::Component::Image < Promethee::Component::Base
  has_attributes do |a|
    a.string :src
    a.string :alt
  end
end
