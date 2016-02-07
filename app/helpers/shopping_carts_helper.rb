module ShoppingCartsHelper
  def price_without_discount_if_any
    if current_cart.sum != current_cart.sum_without_discount
      number_to_currency current_cart.sum_without_discount
    end
  end
end
