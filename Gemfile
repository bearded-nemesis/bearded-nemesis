source 'http://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'thin'

group :production, :staging do
  gem "pg"
end

group :development, :test do
  gem "sqlite3"
  gem "rb-readline"
end

gem 'will_paginate'
gem 'haml-rails'
gem 'devise'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'uglifier', '>= 1.0.3'
end


group :test, :development do
  gem 'rspec-rails', '2.12.0'
end

group :test do
  gem 'factory_girl_rails'
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'database_cleaner'

end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

gem "heroku-rglpk", git: "https://github.com/bearded-nemesis/heroku-rglpk.git"
gem "newrelic_rpm"
gem "nokogiri"

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
