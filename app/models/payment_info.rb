class PaymentInfo < ActiveRecord::Base
  belongs_to :user

  has_many :orders, foreign_key: :payment_id

  validates :user_id,           presence: true
  validates :card,              presence: true
  validates :cvv,               presence: true
  validates :expiration_year,   presence: true
  validates :expiration_month,  presence: true

  validate :card_should_only_contain_digits

  validates :card, length: { is: 16 }
  validates :cvv, numericality: { greater_than_or_equal_to: 100, less_than_or_equal_to: 999 }
  validates :expiration_year, numericality: {
    greater_than_or_equal_to: 2015,
    less_than_or_equal_to: 2100
  }
  validates :expiration_month, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 12
  }

  def card_should_only_contain_digits
    errors.add(:card, "has non-digit chars") if (card.to_i.to_s != card)
  end
end
