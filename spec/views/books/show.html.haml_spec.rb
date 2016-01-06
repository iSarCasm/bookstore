require 'rails_helper'

RSpec.describe "books/show", type: :view do
  context 'when book found' do
    it 'displays book title' do
      book = assign(:book, build(:book))
      render
      expect(rendered).to have_content book.title
    end

    it 'displays book description' do
      book = assign(:book, build(:book))
      render
      expect(rendered).to have_content book.desc
    end

    it 'displays book price' do
      book = assign(:book, build(:book))
      render
      expect(rendered).to have_content book.price
    end
  end

  context 'when book not found' do
    it 'displays error message' do
      render
      expect(rendered).to have_css "p.error"
    end
  end
end
