class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_cart
    if session[:cart].is_a?(ShoppingCart)
      session[:cart]
    else
      session[:cart] = ShoppingCart.new(session)
    end
  end
  # wtf
  helper_method :current_cart
end
