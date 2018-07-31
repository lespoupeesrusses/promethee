class Promethee::Data::Master < Promethee::Data
  def initialize(data)
    super data
    fix_master_integrity
  end

  def flat
    flatten_components @data
  end

  protected

  def fix_master_integrity
    @data[:version] = 1 unless @data.include? :version
    @data[:children] = [] unless @data.include? :children
  end

  # Takes an array of components and puts every component and their children into a unique flat array
  def flatten_components(component)
    flat_components = [component.except(:children)]
    (component[:children] || []).reduce flat_components do |flat_components, component|
      flat_components + flatten_components(component)
    end
  end
end