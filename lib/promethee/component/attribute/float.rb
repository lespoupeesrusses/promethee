class Promethee::Component::Attribute::Float < Promethee::Component::Attribute::Base
  cast { |value| value&.to_f or default }
end
