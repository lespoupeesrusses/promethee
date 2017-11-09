class Promethee::Component::Video < Promethee::Component::Base
  has_attributes do |a|
    a.string :url
  end
end
