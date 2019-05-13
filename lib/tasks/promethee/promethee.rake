namespace :promethee do

  desc "Remove useless attributes from localizations' data"
  task :clean_localizations, [:model_name] do |task, args|
    model_class = args[:model_name]&.try(:constantize)
    if model_class.nil?
      puts 'Please provide a model name (e.g. `rake promethee:clean_localizations[Page]`)'
      exit
    end

    objects = model_class.all

    service = Promethee::LocalizeCleanService.new(objects)
    service.start
  end

  desc "Upgrade your table components' to 2.x structure"
  task :upgrade_table, [:model_name] do |task, args|
    model_class = args[:model_name]&.try(:constantize)
    if model_class.nil?
      puts 'Please provide a model name (e.g. `rake promethee:upgrade_table[Page]`)'
      exit
    end

    objects = model_class.all.select { |obj| obj.data.to_json.include? '"type":"table"' }

    puts '= Start Promethee Table Upgrader ='
    puts "Number of objects: #{objects.count}"
    puts '========== END CLEANER ==========='
  end

end