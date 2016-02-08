module DeviseHelper
  def devise_error_sentence
    I18n.t("errors.messages.not_saved",
           count: resource.errors.count,
           resource: resource.class.model_name.human.downcase)
  end

  def devise_error_messages_for(*fields)
    devise_error_messages.select do |k, _v|
      fields.include? k
    end.inject([]) do |errors, (k, v)|
      errors << "#{name_of_field(k)} #{string_for_errors(v)}"
    end
  end

  def new_user_error_messages
    devise_error_messages_for(:email,
                              :password,
                              :password_confirmation)
  end

  def password_error_messages
    devise_error_messages_for(:current_password,
                              :password,
                              :password_confirmation)
  end

  def devise_address_error_messages_of(model)
    devise_error_messages_for(:"#{model}.first_name",
                              :"#{model}.last_name",
                              :"#{model}.street_address",
                              :"#{model}.city",
                              :"#{model}.country",
                              :"#{model}.zip",
                              :"#{model}.phone")
  end

  def email_error_messages
    devise_error_messages_for(:email)
  end

  def devise_error_messages?
    resource.errors.any?
  end

  def devise_error_messages!
    resource.errors.messages
  end

  protected

  def devise_error_messages
    resource.errors.messages
  end

  def name_of_field(field_key)
    field_key = delete_model_from_key(field_key)
    {
      current_password: "New password",
      password_confirmation: "Password Confirmation",
      first_name: "First Name",
    }.fetch(field_key, default_sym_to_string_pattern(field_key))
  end

  def default_sym_to_string_pattern(sym)
    sym.to_s.gsub('_', ' ').split.map(&:capitalize).join(' ')
  end

  def string_for_errors(error_array)
    error_array.map(&:to_s).join(';')
  end

  def delete_model_from_key(key)
    key.to_s.split('.').last.to_sym
  end
end
