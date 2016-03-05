class Order < ActiveRecord::Base
  include AASM

  has_many :order_items, dependent: :destroy

  belongs_to :user, dependent: :destroy
  belongs_to :billing_address, class_name: "Address", dependent: :destroy
  belongs_to :shipment_address, class_name: "Address", dependent: :destroy
  belongs_to :payment, class_name: "PaymentInfo"
  belongs_to :shipment
  belongs_to :coupon

  before_save do |order|
    order.billing_address.save if order.billing_address.valid?
    order.shipment_address.save if order.shipment_address.valid?
  end

  accepts_nested_attributes_for :billing_address, :shipment_address, :payment

  validates :user, presence: true

  validates :billing_address, presence: true,   if: "!self.in_progress?"
  validates :shipment_address, presence: true,  if: "!self.in_progress?"
  validates :shipment, presence: true,          if: "!self.in_progress?"
  validates :payment, presence: true,           if: "!self.in_progress?"
  validates_associated :billing_address, :shipment_address, :payment, :shipment,
    :coupon, if: "!self.in_progress?"

  def aasm_state_enum
    Order.aasm.states_for_select
  end

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
    order.copy_coupon(cart)
    order.save!
    order
  end

  def add_order_items(cart)
    cart.items.each do |item|
      if item.quantity > 0
        self.order_items.build(book_id: item.id, quantity: item.quantity)
      end
    end
  end

  def create_order_billing_address
    self.billing_address = self.user.billing_address.clone if self.user.billing_address.valid?
  end

  def create_order_shipment_address
    self.shipment_address = self.user.delivery_address.clone  if self.user.delivery_address.valid?
  end

  def set_default_shipment
    self.shipment = Shipment.first
  end

  def copy_coupon(cart)
    self.coupon = cart.coupon
  end

  def sum_without_discount
    order_items.inject(0) { |sum, item| sum + item.sum }
  end

  def sum
    sum_without_discount * (1 - discount)
  end

  def discount_string
    "-#{(coupon.discount*100).to_i}%" if coupon
  end

  def discount
    coupon ? coupon.discount : 0
  end

  def address_invalid?
    !(self.billing_address && self.billing_address.valid?) ||
    !(self.shipment_address && self.shipment_address.valid?)
  end

  def delivery_invalid?
    !(self.shipment)
  end

  def payment_invalid?
    !(self.payment && self.payment.valid?)
  end

  def billing_address
    (super rescue nil) || build_billing_address
  end

  def shipment_address
    (super rescue nil) || build_shipment_address
  end

  def payment
    (super rescue nil) || build_payment(user: self.user)
  end
end

# _   _         _  _          _   __ _
# | | | |  ___  | || |  ___   | | / /(_)  _     _
# | |_| | / _ \ | || | / _ \  | |/ /  _ _| |_ _| |_  _  _
# |  _  |/ /_\ \| || |/ / \ \ |   /  | |_   _|_   _|| |/ /
# | | | |\ ,___/| || |\ \_/ / | |\ \ | | | |_  | |_ | / /
# |_| |_| \___/ |_||_| \___/  |_| \_\|_| \___| \___||  /
#                       _           _              / /
#                      / \_______ /|_\             \/
#                     /          /_/ \__
#                    /             \_/ /
#                  _|_              |/|_
#                  _|_  O    _    O  _|_
#                  _|_      (_)      _|_
#                   \                 /
#                    _\_____________/_
#                   /  \/  (___)  \/  \
#                   \__(  o     o  )__/
