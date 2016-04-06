# Bookstore with Ruby on Rails
[![Build Status](https://travis-ci.org/iSarCasm/bookstore.svg?branch=master)](https://travis-ci.org/iSarCasm/bookstore)

# Functions
## As an Admin
* I want to have access to admin panel.
* I want to be able to manage (create/read/update/delete) books into admin panel.
  * Book data:
    * Title
    * Short description
    * Full description (should support markdown syntax)
    * Authors
    * Categories
    * Image
    * Price
* I want to be able to manage (create/read/update/delete) authors into admin panel.
  * Author data:
    * First name
    * Last name
    * Description
* I want to be able to manage (create/read/update/delete) categories into admin panel.
  * Category data:
    * Name
* I want to be able to manage (read/change state) orders into admin panel. I can change order state to ‘in_delivery’, ‘delivered’, ‘in_queue’, ‘canceled’
  * Order states:
    * in_progress - An user makes a purchase.
    * in_queue - An user has paid an order. The order is waiting for processing.
    * in_delivery - An order in delivery.
    * delivered - An order is delivered.
    * canceled - An order was canceled.
* I want to be able to approve or reject reviews before they're available on the site.

## As an User
* I can see best sellers on the main page
* I can navigate the site by categories
* I can view detailed information about a book on a book page.
* I can put books into a "shopping cart" and buy them when I am done shopping.
* I can remove books from my cart before completing an order.
* To buy a book I need to enter my credit card information: billing address, shipping address etc.
* I can add reviews for books.
* I can establish an account that remembers shipping and billing information.
* I can sign up by FaceBook.
* I can edit my account information (shipping address, billing address and so on).
* I can check the status of my recent orders.
* I can view a history of all of my past orders.

# Tools Used
* __Rails__
* __PostgreSQL__
* __RSpec, Capybara, ShouldaMatchers, Guard-RSpec, database_cleaner, TravisCI - for testing
* __simplecov__ - for test coverage
* __HTML5, CSS3, SCSS, CoffeeScript, HAML, Bootstrap, jQuery__ - Frontend
* __Devise + Omniauth(Facebook, Github)__ - Users and Auth
* __CanCan__ - Authorization
* __RailsAdmin__ - admin panel
* __AASM__ - simple state machine
* __Kaminari__ - Paginator
* __CarrierWave + MiniMagick__ - image works
* __I18n__ - Internationalization
* __MoneyRails__ - money and currency management
* __Heroku, DigitalOcean, Capistrano__ - Deployment
