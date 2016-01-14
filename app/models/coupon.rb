class Coupon < ActiveRecord::Base
  validates :name, presence: true
  validates :discount, presence: true,
            numericality: { greater_than_or_equal_to: 0.00,
                            less_than_or_equal_to: 1.00 }
end
