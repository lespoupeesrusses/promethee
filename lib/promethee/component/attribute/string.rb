class Promethee::Component::Attribute::String < Promethee::Component::Attribute::Base
  cast { |value| value&.to_s or default }
end
