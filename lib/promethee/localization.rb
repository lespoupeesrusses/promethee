class Promethee::Localization 
  def self.localize!(master_data, localization_data)
    localized_components = localization_data[:components].select { |component| component[:id] == master_data[:id] }.first
    master_data[:attributes].merge! localized_components[:attributes] unless localized_components.nil?
    master_data[:children].each { |d| localize! d, localization_data } unless master_data[:children].nil?
  end
end
