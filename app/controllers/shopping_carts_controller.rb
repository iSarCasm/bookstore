class ShoppingCartsController < ApplicationController
  def show
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
    Order.create_from_cart(cart: current_cart, user: current_user)
    render nothing: true
  end
end
