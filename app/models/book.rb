class Book < ActiveRecord::Base
  has_many :book_owns
  has_many :authors, through: :book_owns

  has_many :category_books
  has_many :categories, through: :category_books

  has_many :reviews

  validates :title, presence: true, uniqueness: true
  validates :desc, presence: true
  validates :price, presence: true, numericality: {
    greater_than: 0
  }
  validates :price, format: { with: /\A(\z)?(\d+)(\.|,)?\d{0,2}?\z/ }
  validates :quantity, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  paginates_per 9

  def rating
    self.reviews.where(approved: true).average(:rating) || 0
  end
end
