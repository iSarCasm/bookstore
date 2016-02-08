class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  validates :order, presence: true
  validates :book, presence: true
  validates :quantity, presence: true, numericality: {
    greater_than_or_equal_to: 0
  }

  def price
    book.price
  end

  def sum
    price * quantity
  end
end
