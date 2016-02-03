class Order < ActiveRecord::Base
  include AASM

  has_many :order_items

  belongs_to :billing_address, class_name: "Address"
  belongs_to :shipment_address, class_name: "Address"
  belongs_to :user
  belongs_to :payment, class_name: "PaymentInfo"
  belongs_to :shipment

  validates :user, presence: true
  validates :billing_address, presence: true
  validates :shipment_address, presence: true
  validates :payment, presence: true
  validates :shipment, presence: true

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
end
