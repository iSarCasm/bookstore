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
I can see best sellers on the main page
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVSWxzLXFVQkNaZ2M/edit
I can navigate the site by categories
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVclRtdGVoUTVRRjA/edit
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVS2g5SUJCQnNwd0U/edit
I can view detailed information about a book on a book page.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVLWVRNTNQLXBlUDQ/edit
I can put books into a "shopping cart" and buy them when I am done shopping.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVbzRoMjZSZ2Fkd0k/edit
I can remove books from my cart before completing an order.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVbzRoMjZSZ2Fkd0k/edit
To buy a book I need to enter my credit card information: billing address, shipping address etc.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVaDVaZG1GSlZaU00/edit
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVazBuV0hfaFBWUlU/edit
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVY240T2Zud0hHNG8/edit
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVekhOanlaWXBpS0U/edit
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVNVV6TER4ZEdjSnc/edit
I can add reviews for books.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVM0p1VW9DM01SajQ/edit
I can establish an account that remembers shipping and billing information.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVckNaTVZHVXRiV28/edit
I can sign up by FaceBook.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVckNaTVZHVXRiV28/edit
I can edit my account information (shipping address, billing address and so on).
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVNjVxcHJreTJGX2c/edit
I can check the status of my recent orders.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVcEp3TXFRbVo5NTA/edit
I can view a history of all of my past orders.
https://docs.google.com/a/rubygarage.org/file/d/0B7oKVuAqY8KVcEp3TXFRbVo5NTA/edit
