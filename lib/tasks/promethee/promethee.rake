namespace :promethee do

  desc "Remove useless attributes from localizations' data"
  task :clean_localizations, [:model_name] => :environment do |task, args|
    service = Promethee::LocalizeCleanService.new(args[:model_name])
    service.start
  end

  desc "Upgrade your table components' to 2.x structure"
  task :upgrade_table, [:model_name] => :environment do |task, args|
    service = Promethee::TableUpgradeService.new(args[:model_name])
    service.start
  end

  desc "Upgrade blob data from IDs to signed IDs"
  task :upgrade_blob_data, [:model_name] => :environment do |task, args|
    service = Promethee::BlobUpgradeService.new(args[:model_name])
    service.start
  end

  desc "Upgrade structure to Promethée V4"
  task :upgrade_structure, [:model_name] => :environment do |task, args|
    service = Promethee::StructureUpgraderService.new(args[:model_name])
    service.start
  end

end