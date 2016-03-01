require 'rails_helper'

RSpec.describe "books/show", type: :view do
  def no_reviews
    assign(:reviews, [])
  end

  it 'displays book title' do
    no_reviews
    book = assign(:book, build(:book))
    render
    expect(rendered).to have_content book.title
  end

  it 'displays book description' do
    no_reviews
    book = assign(:book, build(:book))
    render
    expect(rendered).to have_content book.desc
  end

  it 'displays book price' do
    no_reviews
    book = assign(:book, build(:book))
    render
    expect(rendered).to have_content book.price
  end

  it 'displays books categories' do
    no_reviews
    book = assign(:book, build(:book, categories_count: 3))
    render
    book.categories.each do |category|
      expect(rendered).to have_content category.name
    end
  end

  it 'links to books authors' do
    no_reviews
    book = assign(:book, build(:book, authors_count: 3))
    render
    book.authors.each do |author|
      expect(rendered).to have_link(author.name, href: author_path(author))
    end
  end

  it "has 'add to cart' button" do
    no_reviews
    book = assign(:book, build(:book))
    render
    expect(rendered)
      .to have_button 'Add to Cart'
  end

  it 'displays reviews for this book' do
    book = assign(:book, build(:book))
    review_1 = build(:review, book: book, message: "msg 1")
    review_2 = build(:review, book: book, message: "msg 2")
    reviews = assign(:reviews, [review_1, review_2])
    render
    expect(rendered).to have_content "msg 1"
    expect(rendered).to have_content "msg 2"
  end
end
