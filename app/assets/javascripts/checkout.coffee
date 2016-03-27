# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  checkbox = $('#use_billing_address')
  form = $('#shipment_address')
  card = $('#order_payment_attributes_card')

  card.mask '9999 9999 9999 9999',
        placeholder: " "

  checkbox.change ->
    if checkbox.is(':checked')
      form.slideUp()
    else
      form.slideDown()
