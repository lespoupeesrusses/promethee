class Promethee::Localization 
  def self.localize!(data, l10n)
    localized_data = l10n[:components].select { |component| component[:id] == data[:id] }.first
    data[:attributes].merge! localized_data[:attributes] unless localized_data.nil?
    data[:children].each { |d| localize! d, l10n } unless data[:children].nil?
  end
end
