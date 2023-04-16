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
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # CookieとCorsの設定
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies # Required for all session management
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
    config.middleware.use ActionDispatch::Flash
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        # 今回はRailsのポートが3000番、Reactのポートが8080番にするので、Reactのリクエストを許可するためにlocalhost:8080を設定
        origins 'localhost:8080'
        resource '*',
                :headers => :any,
                # この一文で、渡される、'access-token'、'uid'、'client'というheaders情報を用いてログイン状態を維持する。
                :expose => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
                :methods => [:get, :post, :options, :delete, :put]
      end
    end

    # lib配下のクラスも読み込めるように
    config.paths.add 'lib', eager_load: true

    config.std_logger = ActiveSupport::Logger.new($stdout)
    config.batch_logger = ActiveSupport::Logger.new(Rails.root.join('log/batch.log'), 5, 10 * 1024 * 1024)
    config.batch_logger.formatter = ::Logger::Formatter.new
    config.batch_logger.extend(ActiveSupport::Logger.broadcast(config.std_logger))
  end
end
