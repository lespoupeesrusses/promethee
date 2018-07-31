# List of master version and other localizations, flattened
class Promethee::Data::MastersMultiple < Promethee::Data
  def initialize(master, localizations = nil)
    @data = []
    @master = Master.new master
    title = 'Master'
    components = @master.flat
    add_data title, components
    localizations.each do |key, value|
      title = key
      components = Localization.new(value, master).data[:components]
      add_data title, components
    end unless localizations.nil?
  end

  protected

  def add_data(title, components)
    @data << { title: title, components: components }
  end
end