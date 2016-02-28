class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:github]

  attr_accessor :provider, :uid, :email, :password

  belongs_to :billing_address, class_name: "Address", dependent: :destroy
  belongs_to :delivery_address, class_name: "Address", dependent: :destroy

  has_many :payments, class_name: "PaymentInfo", dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :billing_address, :delivery_address


  def self.create_with_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def billing_address
    (super rescue nil) || build_billing_address
  end

  def delivery_address
    (super rescue nil) || build_delivery_address
  end
end
