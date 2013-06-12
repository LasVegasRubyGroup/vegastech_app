source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'rake', '10.0.3'
gem 'sqlite3'
gem 'omniauth-twitter'
gem 'twitter'
gem 'twitter-text'
gem 'tweetstream', '~> 1.0'
gem 'foreman'
gem 'twitter-bootstrap-rails', '2.0.7'
gem 'therubyracer', :platform => :ruby
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem "sidekiq", "~> 2.6.5"
gem 'rest-client'
gem 'sinatra', require: false
gem 'slim'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

def darwin_only(require_as)
  RUBY_PLATFORM.include?('darwin') && require_as
end

def linux_only(require_as)
  RUBY_PLATFORM.include?('linux') && require_as
end

group :development do
  gem 'capistrano'
  gem "rspec-rails"
  gem "guard-rspec"
  gem "guard-spork"
  gem "sqlite3"
  gem 'capistrano-unicorn', :require => false

  # mac
  gem "rb-fsevent", require: darwin_only('rb-fsevent')
  gem "growl", require: darwin_only('growl')

  # linux
  gem 'rb-inotify', require: linux_only('rb-inotify')
  gem 'libnotify', require: linux_only('libnotify')
  gem 'sextant'

end

group :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "database_cleaner"
  gem "capybara"
end

group :production do
  gem "mysql2"
  gem "unicorn"
end
