class Book < ActiveRecord::Base
  mount_uploader :image, PhotoUploader

  has_many :book_owns
  has_many :authors, through: :book_owns

  has_many :category_books
  has_many :categories, through: :category_books

  has_many :order_items
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

  def self.bestseller(count = 5)
    # joins('left join order_items on order_items.book_id = books.id')
    #   .select('books.*, count(order_items.id) as items_count')
    #   .group('books.id')
    #   .order('items_count desc')
    #   .limit(count)
    joins(order_items: :order)
      .where(orders: {aasm_state: ['in_queue','in_delivery','delivered']})
      .select('books.*, SUM(order_items.quantity) as buy_quantity')
      .group('books.id').order('buy_quantity DESC').limit(3)
  end

  def self.from_category(category = nil)
    if category
      self.joins(:category_books)
        .where("category_books.category_id = ?", category)
    else
      self.all
    end
  end
end
