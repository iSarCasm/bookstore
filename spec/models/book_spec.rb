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

  describe '.bestseller' do
    it 'returns most selling books' do
      create_list(:book, 3)

      top_books = create_list(:book, 3)
      some_order = create(:order, aasm_state: 'delivered')
      top_books.each do |b|
        create(:order_item, book: b, quantity: 10, order: some_order)
      end

      create_list(:book, 3)

      expect(Book.bestseller(3)).to match_array top_books
    end
  end

  describe '.from_category' do
    it 'returns all books from selected category' do
      c1 = create(:category)
      c2 = create(:category)
      needed_books  = create_list(:book, 3, category: c1)
      other_books   = create_list(:book, 3, category: c2)
      expect(Book.from_category(c1)).to match_array needed_books
    end

    it 'returns all books when no category' do
      c1 = create(:category)
      c2 = create(:category)
      needed_books  = create_list(:book, 3, category: c1)
      other_books   = create_list(:book, 3, category: c2)
      expect(Book.from_category).to match_array Book.all
    end
  end
end
