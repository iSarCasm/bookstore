require 'rails_helper'
RSpec.describe 'pages/shop.html.haml' do
  context 'when anyone visits the page' do
    it 'shows many books', verify_stubs: false do
      assign(:categories, build_list(:category, 3))
      books = assign(:books, build_list(:book, 5))
      pagination_stub(books)
      render
      books.each do |book|
        expect(rendered).to have_content book.title
      end
    end

    it 'shows existing categories', verify_stubs: false do
      books = assign(:books, build_list(:book, 5))
      pagination_stub(books)
      categories = assign(:categories, build_list(:category, 3))
      render
      categories.each do |category|
        expect(rendered).to have_content category.name
      end
    end

    it 'has links to a books', verify_stubs: false do
      assign(:categories, build_list(:category, 3))
      books = assign(:books, build_list(:book, 5))
      pagination_stub(books)
      render
      books.each do |book|
        expect(rendered).to have_link(nil, href: book_path(book))
      end
    end

    it 'has links to a categories', verify_stubs: false do
      categories = assign(:categories, build_list(:category, 3))
      books = assign(:books, build_list(:book, 5))
      pagination_stub(books)
      render
      categories.each do |category|
        expect(rendered).to have_link(nil, href: index_path(category: category))
      end
    end

    it 'has page links', verify_stubs: false do
      assign(:categories, build_list(:category, 3))
      books = assign(:books, build_list(:book, 50))
      pagination_stub(books)
      render
      expect(rendered).to have_link '2'
      expect(rendered).to have_link '3'
    end
  end
end
