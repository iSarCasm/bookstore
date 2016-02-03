class Order < ActiveRecord::Base
  include AASM

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

  aasm do
    state :in_progress, initilial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :queue do
      transitions from: :in_progress, to: :in_queue
    end

    event :ship do
      transitions from: :in_queue, to: :in_delivery
    end

    event :deliver do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions to: :canceled
    end
  end

  def shipment_has_strict_types
    incorrect_type = SHIPMENT_TYPES.all? do |correct_type|
      shipment != correct_type
    end
    errors.add(:shipment, "incorrect type") if incorrect_type
  end
end
