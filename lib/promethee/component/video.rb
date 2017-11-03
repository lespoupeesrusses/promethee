class Promethee::Component::Video < Promethee::Component::Base
  has_attributes do |a|
    a.string :src
  end
end
