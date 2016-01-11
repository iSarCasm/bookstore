class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :billing_address, class_name: "Address"
  belongs_to :delivery_address, class_name: "Address"

  def billing_address
    (super rescue nil) || Address.new
  end

  def delivery_address
    (super rescue nil) || Address.new
  end
end
