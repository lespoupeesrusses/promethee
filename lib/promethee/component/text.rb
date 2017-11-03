class Promethee::Component::Text < Promethee::Component::Base
  has_attributes do |a|
    a.string :body, default: ''
  end
end
