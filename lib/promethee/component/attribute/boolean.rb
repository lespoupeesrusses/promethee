class Promethee::Component::Attribute::Boolean < Promethee::Component::Attribute::Base
  default false
  cast { |value| !!value }
end
