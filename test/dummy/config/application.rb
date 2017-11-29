require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'promethee'

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    Promethee.configure do |config|
      config.route_scope = :promethee_hey
    end
  end
end

