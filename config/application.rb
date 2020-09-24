require_relative 'boot'

require 'rails/all'
Bundler.require(*Rails.groups)

module GrapePlayground
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.assets.enabled = false
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.

    config.autoload_paths << Rails.root.join('lib')

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get patch put delete post options head]
      end
    end

    config.generators do |g|
      g.orm :active_record
      g.template_engine :erb
      g.stylesheets false
      g.test_framework :rspec
    end

    config.time_zone = 'Asia/Seoul'

    config.api_only = false
  end
end
