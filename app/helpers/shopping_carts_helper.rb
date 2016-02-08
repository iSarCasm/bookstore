module ShoppingCartsHelper
  def price_without_discount_if_any(obj)
    if obj.sum != obj.sum_without_discount
      number_to_currency obj.sum_without_discount
    end
  end
end
