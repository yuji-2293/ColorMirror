source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms:  %i[mswin mingw x64_mingw jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mswin mingw x64_mingw], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  # gem "brakeman", require: false
  gem "brakeman", "~> 7.1.0"

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end

# ユーザー認証機能[deviceの導入]
gem "devise"

# 国際化対応
gem "rails-i18n"

# 環境変数設定
gem "dotenv-rails", groups: [ :development, :test ]
# railsプロジェクトでOpenAI APIを使うgem
gem "ruby-openai"
# lintチェックツール
gem "rubocop"
# httpリクエストをサポートするgem
gem "httparty"
# RailsのcontrollerからJSファイルへデータを渡すgem
gem "gon"
# enum サポート
gem "enumerize"
# 開発環境用のメール確認
group :development do
  gem "letter_opener_web"
end
# omniauth
gem "omniauth"

gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"

gem "mission_control-jobs"

gem "line-bot-api"
# OGP用のgem
gem "meta-tags"

# rspecテストコード用gem
group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "simplecov", require: false
  gem "shoulda-matchers", "~> 5.0"
  gem "faker"
end
