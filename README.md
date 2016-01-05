# Bookstore with Ruby on Rails
[![Build Status](https://travis-ci.org/iSarCasm/bookstore.svg?branch=master)](https://travis-ci.org/iSarCasm/bookstore)

# Agile TODO list
## 0. Setup the environment
- Init git repo (use SSL)
- .ruby-version & .ruby-gemset
- Init PostgreSQL
- Init RSpec + Capybara + DatabaseCleaner + ShouldaMathcers + RSpec-fire + Travis CI + Faker + FactoryGirl
- Init rubocop
- Init Guard (rspec and rubocop)
- Prepare to Front-End:
  * Bootstrap
  * jQuery
  * HAML
  * Compass(???)
- Production server
  * PostgreSQL
  * nginx + Unicorn
  * Capistrano

## 1 Sprint
- Visitors can preview books divided into categories
- Books have an Author, Title, Images, Description, Price, Quantity
- Author has Name, Books, Born-date, Country, Description
- Categories have Name, Books
- Page pagination with Kaminari

## 2 Sprint
- Shopping cart
- User registration and authorization
- User has Email, Password, FullName, Billing Address, Delivery Address, Orders
- Checkout
- Orders
- Coupons

## 3 Sprint
- I18n
- RailsAdmin

## 4 Sprint
- Leaving Reviews
- Bestsellers
- Mailer
- Encrypted Passwords
- Facebook auth
- Password Reset

## 5 Sprint
- Git, Twitter and VK auth
- Book sort
- Metrics

## 6 Sprint
- Benchmarking
- Security

## 7 Sprint
- Live Help
- Book API (related books)
