class Promethee::Component::Attribute::Integer < Promethee::Component::Attribute::Base
  cast { |value| value&.to_i or default }
end
