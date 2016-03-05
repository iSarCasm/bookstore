class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
      l = cookies[:educator_locale].to_sym
    else
      l = I18n.default_locale
      cookies.permanent[:educator_locale] = l
    end
    I18n.locale = l
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => exception.message
  end

  def current_cart
    @_shopping_cart ||= ShoppingCart.new(session)
  end
  helper_method :current_cart

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit({ billing_address_attributes:
                [
                  :id,
                  :first_name,
                  :last_name,
                  :street_address,
                  :city,
                  :country,
                  :zip,
                  :phone
                ]
              },
              { delivery_address_attributes:
                [
                  :first_name,
                  :last_name,
                  :street_address,
                  :city,
                  :country,
                  :zip,
                  :phone
                ]
              },
              :email,
              :password,
              :password_confirmation,
              :current_password)
    end
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end
end
