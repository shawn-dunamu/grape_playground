source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

# Rails Server
gem 'rails', '5.2.3'
gem 'rails-i18n', '5.1.1'
gem 'rack', '>= 2.0.6'
gem 'rack-cors', '>= 1.0.4'
gem 'responders'
gem 'pry-rails'
gem 'puma', '>= 3.12.2'
gem 'daemons-rails'

# Grape
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-rails'

# Drivers
gem 'mysql2', '~> 0.5', platform: :ruby

# ActionView
gem 'slim-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'browser'

# ActiveRecord & ActiveModel
gem 'aasm'
gem 'after_commit_everywhere'
gem 'enumerize'
gem 'paranoia', '~> 2.4'

# Security & Authentication
gem 'bcrypt'
gem 'jwt', '2.1.0'

# Runtime
gem 'execjs'
gem 'therubyracer', platform: :ruby

# Environments
gem 'figaro', github: 'neocoin/figaro'
gem 'hashie'

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
end

group :development do
  gem 'factory_bot_rails'
  gem 'dotenv-rails'
  gem 'faker' # doc용
  gem 'colorize'
  gem 'parallel_tests'

  gem 'pry'
  gem 'pry-nav'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-instafail', require: false
  gem 'simplecov', require: false
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers', require: 'rspec/collection_matchers'
  gem 'rspec-retry', require: 'rspec/retry'
  gem 'database_cleaner'
  gem 'mocha', :require => false
  gem 'shoulda-matchers', '4.0.0.rc1'
end