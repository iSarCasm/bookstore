class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  before_action :set_locale

  def store_location
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/sign_out" &&
        !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || index_path
  end

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

  def current_currency
    @_currency ||= cookies[:current_currency] || Money.default_currency
  end
  helper_method :current_currency

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
