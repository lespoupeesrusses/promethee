class Promethee::Data
  def initialize(data)
    @data = hashify data
  end

  def data
    @data
  end

  # The class creates a facade in front of the real hash, therefore include?, [] and to_json are delegated
  def include?(value)
    @data.include? value
  end

  def [](value)
    @data[value]
  end

  def to_json
    @data.to_json
  end

  protected

  def hashify(data)
    # https://github.com/bbatsov/ruby-style-guide#indent-conditional-assignment
    h = case data.class.to_s
        when 'Hash', 'ActiveSupport::HashWithIndifferentAccess' then data
        when 'String' then JSON.parse data
        else {}
        end
    h.deep_symbolize_keys
  end
end
