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
source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
end


gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.0'
  gem 'faker'
  gem 'factory_girl'
  gem 'pry'
  gem 'awesome_print'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'rubocop',        require: false
  gem 'guard-rspec',    require: false
  gem 'guard-rubocop',  require: false
  gem 'spring'
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-unicorn-nginx', '~> 3.2.0'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
end
