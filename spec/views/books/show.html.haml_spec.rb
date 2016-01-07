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

    it 'displays books authors' do
      book = assign(:book, build(:book, authors_count: 3))
      render
      book.authors.each do |author|
        expect(rendered).to have_content author.name
      end
    end

    it 'links to books authors' do
      book = assign(:book, build(:book, authors_count: 3))
      render
      book.authors.each do |author|
        expect(rendered).to have_link(nil, href: author_path(author))
      end
    end
  end
end