class Author < ActiveRecord::Base
  has_many :book_owns
  has_many :books, through: :book_owns

  validates :name, presence: true
  validates :name, uniqueness: true
end
