require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should have_db_column :title }
  it { should have_db_column :desc }
  it { should have_db_column :price }
  it { should have_db_column :quantity }

  it { should validate_presence_of :title }
  it { should validate_presence_of :desc }
  it { should validate_presence_of :price }
  it { should validate_presence_of :quantity }
  it { should validate_uniqueness_of :title }
  it { should validate_numericality_of(:price).is_greater_than(0) }
  it { should validate_currency_of :price }
  it { should validate_numericality_of(:quantity)
        .is_greater_than_or_equal_to(0)}

  # wtf
  # https://github.com/thoughtbot/shoulda-matchers/issues/849
  # it { should validate_numericality_of(:quantity).only_integer }

  it { should have_many(:authors).through(:book_owns) }
  it { should have_many(:categories).through(:category_books) }
  it { should have_many(:reviews) }

  describe '#rating' do
    it 'returns average rating of book from approved reviews' do
      book = create(:book)
      approved_reviews      = create_list(:review, 2, rating: 5, book: book, approved: true)
      non_approved_reviews  = create_list(:review, 1, rating: 1, book: book)
      expect(book.rating).to eq(5)
    end

    it 'returns 0 when no reviews yet' do
      book = create(:book)
      non_approved_reviews  = create_list(:review, 1, rating: 1, book: book)
      expect(book.rating).to eq(0)
    end
  end
end
