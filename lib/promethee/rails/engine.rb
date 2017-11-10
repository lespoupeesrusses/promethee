class Promethee::Rails::Engine < ::Rails::Engine
  initializer 'helper' do |app|
    ActiveSupport.on_load :action_view do
      include Promethee::Rails::Helper
    end
  end
  initializer 'assets' do |app|
    Rails.application.config.assets.precompile += %w( logo-promethee-vertical.svg logo-promethee-horizontal.svg icon-promethee.png )
    # Rails.application.config.assets.paths << Rails.root.join('vendor')
  end
end
