module ApplicationHelper
  def html_for_errors(errors, type: 'danger')
    return '' if errors.empty?

    points = errors.inject('') do |html, error|
      html += content_tag(:li, error)
    end
    block = content_tag(:ol, points.html_safe)
    raw content_tag(:div, block.html_safe, class: ['alert', "alert-#{type}"])
  end

  def number_to_money(val)
    begin
      humanized_money_with_symbol val.exchange_to(current_currency)
    rescue
      number_to_currency val
    end
  end
end
