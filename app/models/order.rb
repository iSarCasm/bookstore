class Order < ActiveRecord::Base
  belongs_to :billing_address, class_name: "Address"
  belongs_to :shipment_address, class_name: "Address"
  belongs_to :user
  belongs_to :payment, class_name: "PaymentInfo"

  validates :user, presence: true
  validates :billing_address, presence: true
  validates :shipment_address, presence: true
  validates :payment, presence: true
  validates :shipment, presence: true

  SHIPMENT_TYPES = ["UPS Ground", "UPS Two Day", "UPS One Day"]
  validate :shipment_has_strict_types

  def shipment_has_strict_types
    incorrect_type = SHIPMENT_TYPES.all? do |correct_type|
      shipment != correct_type
    end
    errors.add(:shipment, "incorrect type") if incorrect_type
  end
end
