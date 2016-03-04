class PaymentInfo < ActiveRecord::Base
  belongs_to :user

  has_many :orders, foreign_key: :payment_id

  validates :user_id,           presence: true
  validates :card,              presence: true
  validates :cvv,               presence: true
  validates :expiration_year,   presence: true
  validates :expiration_month,  presence: true

  validate :card_should_only_contain_digits
  validate :cvv_is_3_char_length

  validates :card, length: { is: 16 }
  validates :expiration_year, numericality: {
    greater_than_or_equal_to: 2015,
    less_than_or_equal_to: 2100
  }
  validates :expiration_month, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 12
  }

  def cvv_is_3_char_length
    errors.add(:cvv, "not 3 digit length") if (cvv.to_s.size != 3)
  end

  def card_should_only_contain_digits
    errors.add(:card, "has non-digit chars") if (card.to_i.to_s != card)
  end
end
