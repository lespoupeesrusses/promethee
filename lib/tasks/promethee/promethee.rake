namespace :promethee do

  desc "Remove useless attributes from localizations' data"
  task :clean_localizations, [:model_name] do |task, args|
    service = Promethee::LocalizeCleanService.new(args[:model_name])
    service.start
  end

  desc "Upgrade your table components' to 2.x structure"
  task :upgrade_table, [:model_name] do |task, args|
    # TODO
  end

end