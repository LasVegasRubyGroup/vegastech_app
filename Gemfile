source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'omniauth-twitter'
gem 'twitter'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'twitter-bootstrap-rails'
  gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
	gem "rspec-rails"
  gem "guard-rspec"
  gem "guard-spork"

  # Nick installed this to get growl notifications to work with Guard
  gem 'ruby_gntp'

# mac
  gem "rb-fsevent" if RUBY_PLATFORM.downcase.include?("darwin")
  gem "growl" if RUBY_PLATFORM.downcase.include?("darwin")

# linux
  gem 'rb-inotify' if RUBY_PLATFORM.downcase.include?("linux")
  gem 'libnotify' if RUBY_PLATFORM.downcase.include?("linux")

end

group :test do
	gem "rspec-rails"
  gem "factory_girl_rails"
  gem "database_cleaner"
  gem "capybara"
end
