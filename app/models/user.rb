class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :billing_address, class_name: "Address"
  belongs_to :delivery_address, class_name: "Address"

  has_many :payments, class_name: "PaymentInfo"
  has_many :orders
  has_many :reviews

  accepts_nested_attributes_for :billing_address, :delivery_address

  def billing_address
    (super rescue nil) || build_billing_address
  end

  def delivery_address
    (super rescue nil) || build_delivery_address
  end
end
