class CartsController < ApplicationController
  def add
    # binding.pry
    current_cart.add(params[:book]) if params[:book]
    # binding.pry
    respond_to do |format|
      format.js {}
      format.html { redirect_to :back }
    end
  end
end
