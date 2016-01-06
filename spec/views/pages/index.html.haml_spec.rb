require 'rails_helper'

RSpec.describe 'pages/index.html.haml' do
  context 'when anyone visits the page' do
    it 'shows many books' do
      assign(:categories, build_list(:category, 3))
      books = assign(:books, build_list(:book, 5))
      render
      books.each do |book|
        expect(rendered).to have_content book.title
      end
    end

    it 'shows existing categories' do
      assign(:books, build_list(:book, 5))
      categories = assign(:categories, build_list(:category, 3))
      render
      categories.each do |category|
        expect(rendered).to have_content category.name
      end
    end
  end
end
