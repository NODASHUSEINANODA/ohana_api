require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = false

    # lib配下のクラスも読み込めるように
    config.paths.add 'lib', eager_load: true

    config.std_logger = ActiveSupport::Logger.new($stdout)
    config.batch_logger = ActiveSupport::Logger.new(Rails.root.join('log/batch.log'), 5, 10 * 1024 * 1024)
    config.batch_logger.formatter = ::Logger::Formatter.new
    config.batch_logger.extend(ActiveSupport::Logger.broadcast(config.std_logger))

    # ロケールを日本に設定
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  end
end
