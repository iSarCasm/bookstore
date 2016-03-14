class ShoppingCart::CheckoutController < ShoppingCart::ApplicationController
  def checkout
    if can? :checkout, :cart
      order = Order.create_from_cart(cart: current_cart, user: current_user)
      current_cart.clear
      current_cart.save
      redirect_to main_app.edit_address_checkout_path(order)
    else
      redirect_to main_app.new_user_session_path, redirect_path: cart_path
    end
  end
end
