class Promethee::Rails::Engine < ::Rails::Engine
  initializer 'helper' do |app|
    ActiveSupport.on_load :action_view do
      include Promethee::Rails::Helper
    end

    Sprockets::Context.send :include, ActionView::Helpers
    Sprockets::Context.send :include, Promethee::Rails::Helper
  end
end
