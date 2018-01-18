require_relative 'boot'

require "active_model/railtie" 
require "active_job/railtie"
# require "active_record/railtie" 
require "action_controller/railtie" 
require "action_mailer/railtie" 
require "action_view/railtie" 
require "sprockets/railtie" 
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)
require 'promethee'

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

