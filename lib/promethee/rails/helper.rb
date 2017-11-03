module Promethee::Rails::Helper
  def promethee(data)
    Promethee::Grid.new(data).show
  end
end
