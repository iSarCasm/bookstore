class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_cart
    @_shopping_cart ||= ShoppingCart.new(session)
  end
  helper_method :current_cart
end
