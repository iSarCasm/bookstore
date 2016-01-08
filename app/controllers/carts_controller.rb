class CartsController < ApplicationController
  def add
    current_cart.add(params[:book]) if params[:book]
    respond_to do |format|
      format.js {}
      format.html { redirect_to :back }
    end
  end

  def current_cart
    session[:cart] ||= ShoppingCart.new
  end
end
