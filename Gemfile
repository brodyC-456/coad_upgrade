source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.8"

# Rails
gem "rails", "~> 8.1.2"

# Web server
gem "puma", ">= 5.0"

# Asset pipeline
gem "propshaft"
gem "sassc-rails" # keep for SCSS support
# gem "uglifier" # optional, can remove if using jsbundling-rails
# gem "turbolinks" # replaced by turbo-rails if you want Turbo

# JS & frontend
gem "jquery-rails" # optional if you still use jQuery
gem "bootstrap", "~> 4.4.1"

# Active Storage
gem "image_processing", "~> 1.2"

# Error tracking
gem "airbrake", "~> 13.0.3"

# Authentication
gem 'devise', '~> 5.0'

# Templating
gem "haml", "~> 6.1.1"
gem "haml-rails", "~> 2.1.0"

# APIs / JSON
gem "jbuilder", "~> 2.5"

# Pagination & phone
gem "pagy", "~> 43.3.1"
gem "phony_rails", "~> 0.15.0"

# CAPTCHA
gem "recaptcha", "~> 5.12.3", require: "recaptcha/rails"

# Caching & performance
gem "bootsnap", require: false

# Database
gem "sqlite3", ">= 2.1"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Observer
gem 'observer', require: true

# Development & debugging
group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails", "~> 2.8.1"
  gem "factory_bot_rails", "~> 6.3"
  gem "rspec-rails", "~> 6.0" # update for Rails 8
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "guard-rspec", require: false
  gem "letter_opener"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "webdrivers"
  gem "rails-controller-testing"
  gem "database_cleaner-active_record"
end