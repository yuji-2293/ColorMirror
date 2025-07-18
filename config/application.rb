require_relative "boot"

require "rails/all"
require "openai"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # testファイルやヘルバーファイルの生成を抑制する

    config.generators.system_tests = nil
    config.generators do |g|
      g.skip_routes true
      g.helper false
      g.test_framework nil
    end
    # # サービスディレクトリへのルート設定
    # config.autoload_paths << Rails.root.join("app/services")

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.hosts << "https://colormirror.jp/"
    config.mission_control.jobs.http_basic_auth_enabled = false

    config.i18n.default_locale = :ja
    config.time_zone = "Tokyo"
    config.autoload_paths |= [ Rails.root.join("app/services").to_s ]
    config.autoload_paths |= [ Rails.root.join("lib").to_s ]
  end
end
