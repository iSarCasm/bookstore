require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    I18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :en # set default locale to Russian
  end
end
