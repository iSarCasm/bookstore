class Order < ActiveRecord::Base
  include AASM

  DEFAULT_SHIPMENT_ID = 1

  has_many :order_items

  belongs_to :user, dependent: :destroy
  belongs_to :billing_address, class_name: "Address",   autosave: true
  belongs_to :shipment_address, class_name: "Address",  autosave: true
  belongs_to :payment, class_name: "PaymentInfo",       autosave: true
  belongs_to :shipment

  before_destroy do |order|
    order.billing_address.destroy
    order.shipment_address.destroy
  end

  before_save do |order|
    order.billing_address.save
    order.shipment_address.save
  end

  accepts_nested_attributes_for :billing_address, :shipment_address

  validates :user, presence: true

  validates :billing_address, presence: true,   if: "self.in_queue?"
  validates :shipment_address, presence: true,  if: "self.in_queue?"
  validates :shipment, presence: true,          if: "self.in_queue?"
  validates :payment, presence: true,           if: "self.in_queue?"
  validates_associated :billing_address, :shipment_address, :payment, :shipment,
      if: "self.in_queue?"


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
    order
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

  def billing_address
    (super rescue nil) || build_billing_address
  end

  def shipment_address
    (super rescue nil) || build_shipment_address
  end
end
