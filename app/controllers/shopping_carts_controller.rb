class ShoppingCartsController < ApplicationController
  def show
    render 'orders/empty_cart' if current_cart.empty?
  end

  def update
    if params[:book]
      current_cart.add(params[:book])
      current_cart.save
    end

    if params[:coupon]
      current_cart.apply_coupon(params[:coupon])
      current_cart.save
    end

    respond_to do |format|
      format.js {}
      format.html { redirect_to :back }
    end
  end

  def checkout
    if current_user
      order = Order.create_from_cart(cart: current_cart, user: current_user)
      current_cart.clear
      current_cart.save
      redirect_to edit_address_order_path(order)
    else
      redirect_to new_user_session_path, redirect_path: cart_path
    end
  end

  def clear
    current_cart.clear
    current_cart.save
    redirect_to cart_path
  end
end
