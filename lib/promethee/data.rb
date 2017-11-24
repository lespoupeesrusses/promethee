class Promethee::Data 
  def self.prepare(data)
    if data.is_a? String
      JSON.parse data, symbolize_names: true 
    else
      data
    end
  end
end
