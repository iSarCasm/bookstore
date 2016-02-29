source 'https://rubygems.org'

gem 'rails', '4.2.5'
gem 'pg'
gem 'unicorn'

# Asset Pipeline
gem "haml-rails", "~> 0.9"
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'
gem "autoprefixer-rails"
gem 'uglifier', '>= 1.3.0'

# Assets
gem 'normalize-rails'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 4.5.0'
source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
end

gem 'kaminari'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'faker'

gem 'devise'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-facebook'

gem 'aasm'
gem 'rails_admin'
gem 'carrierwave'
gem "mini_magick"
gem 'cancancan', '~> 1.10'

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.0'
  gem 'factory_girl'
  gem 'pry'
  gem 'awesome_print'
  gem 'kaminari-rspec'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'rubocop',        require: false
  gem 'guard-rspec',    require: false
  gem 'guard-rubocop',  require: false
  gem 'spring'
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-safe-deploy-to', '~> 1.1.1'
  gem 'capistrano-unicorn-nginx', '~> 3.2.0'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
end

group :test do
  gem 'simplecov', require: false
end
