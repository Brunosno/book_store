require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "active_storage/engine"


Bundler.require(*Rails.groups)

module BookStore
  class Application < Rails::Application
    config.load_defaults 8.0

    config.api_only = true

    config.autoload_paths << Rails.root.join("app/errors")
  end
end
