# Bookstore with Ruby on Rails
[![Build Status](https://travis-ci.org/iSarCasm/bookstore.svg?branch=master)](https://travis-ci.org/iSarCasm/bookstore)

# Functions
## As an Admin
* I want to have access to admin panel.
* I want to be able to manage (create/read/update/delete) books into admin panel. 
* * Book data:
*** Title
Short description
Full description (should support markdown syntax)
Authors
Categories
Image
Price
I want to be able to manage (create/read/update/delete) authors into admin panel.
Author data:
First name
Last name
Description
I want to be able to manage (create/read/update/delete) categories into admin panel.
Category data:
Name
I want to be able to manage (read/change state) orders into admin panel. I can change order state to ‘in_delivery’, ‘delivered’, ‘in_queue’, ‘canceled’
Order states:
in_progress - An user makes a purchase.
in_queue - An user has paid an order. The order is waiting for processing.
in_delivery - An order in delivery.
delivered - An order is delivered.
canceled - An order was canceled.
I want to be able to approve or reject reviews before they're available on the site.
