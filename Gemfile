source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.6'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# Provides higher-level image processing helpers that are commonly needed when handling image uploads. Read more: https://github.com/janko/image_processing
gem 'image_processing', '~> 1.12'
# Useful HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web. Read more: http://getbootstrap.com
gem 'bootstrap', '~> 4.3.1'
# jQuery for Rails. Read more: https://github.com/rails/jquery-rails
gem 'jquery-rails'
# AWS Ruby gem for Amazon Simple Storage Service (Amazon S3). Read more: https://github.com/aws/aws-sdk-ruby
gem "aws-sdk-s3", "~> 1.103"
# To make it easy to securely configure Rails applications. Read more: https://github.com/laserlemon/figaro
gem "figaro", "~> 1.2"
# To make it easier to handle nested forms. Read more: https://github.com/nathanvda/cocoon
gem "cocoon", "~> 1.2"
# ActiveStorage blob validator. Read more: https://github.com/aki77/activestorage-validator
gem "activestorage-validator", "~> 0.1.5"
# Allows you to easily generate a diagram based on your application's Active Record models. Read more: https://github.com/voormedia/rails-erd
gem "rails-erd", "~> 1.6"
# To upload to Heroku
gem 'sqlite3', group: :development
gem 'pg', group: :production
