class SettingsController < ApplicationController
  def change_locale
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:educator_locale] = l
    redirect_to request.referer || index_url
  end

  def change_currency
    cookies[:current_currency] = params[:currency].to_s.strip.to_sym
    # binding.pry
    redirect_to request.referer || index_url
  end
end
