class Shipment < ActiveRecord::Base
  has_many :orders

  validates :name, presence: true
  validates :cost, presence: true, numericality: {
    greater_than: 0
  }
end
