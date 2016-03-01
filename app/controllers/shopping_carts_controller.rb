class ShoppingCartsController < ApplicationController
  def show
    render 'checkouts/empty_cart' if current_cart.empty?
  end

  def add
    current_cart.add(params[:book], params[:quantity].to_i)
    current_cart.save

    respond_to do |format|
      format.js {}
      format.html { redirect_to :back }
    end
  end

  def update
    if params[:coupon] != ""
      current_cart.apply_coupon(params[:coupon])
    end

    if params[:cart_items]
      params[:cart_items].each do |id, qnt|
        current_cart.update(id, qnt[:quantity])
      end
    end

    current_cart.save

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
      redirect_to edit_address_checkout_path(order)
    else
      redirect_to new_user_session_path, redirect_path: shopping_carts_path
    end
  end

  def clear
    current_cart.clear
    current_cart.save
    redirect_to shopping_carts_path
  end
end
