class ShoppingCartsController < ApplicationController
  def show
  end

  def update
    current_cart.add(params[:book]) if params[:book]
    respond_to do |format|
      format.js {}
      format.html { redirect_to :back }
    end
  end
end
