source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails' # envファイルを使用する
  gem 'rspec-rails', '~> 4.0.1'

  gem 'pry-byebug'
  gem 'pry-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'letter_opener_web'
end

gem 'faker', '3.1.1'

gem 'gimei', '1.1.0'

gem 'romaji', '0.2.4'

# ログイン関連のgem追加
# Devise
gem 'devise'
# deviseの日本語化
gem 'devise-i18n'
# HTTP通信
gem 'rack-cors'

# .envを使えるようにする
gem 'dotenv-rails'

# `rubocop`コマンドでlintを走らせて、コードを整形できる(-aオプションで自動修正も可能)
gem 'rubocop', require: false
gem 'rubocop-rails', require: false

# sassを追加
gem 'sassc-rails'

gem 'bootstrap', '~> 5.0.2'

# jquery
gem 'jquery-rails'

# エラーメッセージの日本語化
gem 'rails-i18n'

# enumを日本語化
gem 'enum_help'

# 論理削除(注文のしない方向け)
gem 'discard', '~> 1.2'

# 定数管理
gem 'config'

# enumerize
gem 'enumerize'
