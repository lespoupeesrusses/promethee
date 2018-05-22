Rails.application.config.assets.paths << Promethee.root + 'node_modules'
Rails.application.config.assets.precompile += %w( loader.gif )
