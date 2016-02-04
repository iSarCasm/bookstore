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
  validates :shipment, presence: true

  DEFAULT_SHIPMENT_ID = 1

  aasm do
    state :in_progress, initilial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :enqueue do
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

  def self.create_from_cart(cart: nil, user: nil)
    order = user.orders.build
    order.add_order_items(cart)
    order.create_order_billing_address
    order.create_order_shipment_address
    order.set_default_shipment
    order.save!
  end

  def add_order_items(cart)
    cart.items.each do |item|
      self.order_items.build(book_id: item.id, quantity: item.quantity)
    end
  end

  def create_order_billing_address
    self.billing_address = self.user.billing_address.clone
  end

  def create_order_shipment_address
    self.shipment_address = self.user.delivery_address.clone
  end

  def set_default_shipment
    self.shipment = Shipment.find(DEFAULT_SHIPMENT_ID)
  end
end
