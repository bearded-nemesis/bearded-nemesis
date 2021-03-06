source 'http://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'thin', '~> 1.5.0'

group :production, :staging do
  gem "pg", '~> 0.14.1'
end

gem 'will_paginate', '~> 3.0.4'
gem 'haml-rails', '~> 0.3.5'
gem 'devise', '~> 2.2.2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-rails', "~> 2.2.0"
  gem 'jquery-ui-rails', "~> 3.0.1"
  gem 'underscore-rails', "~> 1.4.3"
  gem 'uglifier', '>= 1.0.3'
end


group :test, :development do
  gem "sqlite3"
  gem "rb-readline"
  gem 'rspec-rails', '~> 2.12.0'
  gem 'jasminerice'
  gem 'poltergeist', git: "https://github.com/jonleighton/poltergeist"
  gem 'factory_girl_rails'
  gem 'cucumber-rails', require: false
  gem 'capybara'
end

group :test do
  gem 'database_cleaner'
end

group :development do
  gem "guard-rspec"
  gem "guard-cucumber"
  gem "spork-rails"
  gem "guard-spork"
  gem 'guard-jasmine'
  gem 'rb-inotify', '~> 0.8.8'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

gem "heroku-rglpk", git: "https://github.com/bearded-nemesis/heroku-rglpk.git"
gem "newrelic_rpm", '~> 3.5.6.46'
gem "nokogiri", '~> 1.5.6'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
