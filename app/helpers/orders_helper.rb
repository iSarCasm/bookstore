module OrdersHelper
  def error_messages_for(errors, *fields)
    return [] unless errors
    errors.select do |k, _v|
      fields.include? k
    end.inject([]) do |errors, (k, v)|
      errors << "#{name_of_field(k)} #{string_for_errors(v)}"
    end
  end


  def address_error_messages_of(errors, model)
    error_messages_for(errors,
                        "#{model}.first_name",
                        "#{model}.last_name",
                        "#{model}.street_address",
                        "#{model}.city",
                        "#{model}.country",
                        "#{model}.zip",
                        "#{model}.phone")
  end

  def payment_error_messages_of(errors, model)
    error_messages_for(errors,
                        "#{model}.card",
                        "#{model}.expiration_year",
                        "#{model}.expiration_month",
                        "#{model}.cvv")
  end

  def safe_card_number(card)
    card.split("").map.with_index do |c, i|
      ( i < 12 ? '*' : c)
    end.join("")
  end

  protected

  def name_of_field(field_key)
    field_key.to_s.gsub('_', ' ').gsub('.', ' ').split.map(&:capitalize).join(' ')
  end

  def string_for_errors(error_array)
    error_array.map(&:to_s).join(';')
  end
end
