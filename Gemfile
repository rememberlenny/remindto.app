source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "sidekiq"

gem "rack-cors"

gem "chronic"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.0"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 3.11"
gem "premailer-rails"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 4.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "ahoy_email"
gem "postmark-rails"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

group :development do
  gem "annotate"
end

group :development do
  gem "letter_opener_web", "~> 1.0"
end

gem "letter_opener"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

group :development do
  gem "brakeman"
end
gem "friendly_id", "~> 5.2.4" # Note: You MUST use 5.0.0 or greater for Rails 4.0+
gem "foreman"
gem "faraday"
gem "oj"
gem "simple_form"
gem "ahoy_matey"
gem "devise"
gem "sanitize"
gem "ruby-oembed"
gem "omniauth"
gem "omniauth-facebook"
gem "maily"
gem "cancancan"
gem "haml"
gem "haml-rails"
gem "draper"
gem "addressable"
gem "settingslogic"
gem "chartkick"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "rubocop", "~> 0.75.1", require: false
  gem "rails_best_practices"
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "pry", "~> 0.12.2"
gem "metainspector"
