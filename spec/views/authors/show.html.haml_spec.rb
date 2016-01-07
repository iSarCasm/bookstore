require 'rails_helper'

RSpec.describe "authors/show", type: :view do
  it 'displays author name' do
    author = assign(:author, build(:author))
    render
    expect(rendered).to have_content author.name
  end

  it 'displays author description' do
    author = assign(:author, build(:author))
    render
    expect(rendered).to have_content author.desc
  end

  it 'displays author born date' do
    author = assign(:author, build(:author))
    render
    expect(rendered).to have_content author.born
  end

  it 'displays author country' do
    author = assign(:author, build(:author))
    render
    expect(rendered).to have_content author.country
  end

  it 'displays author book list' do
    author = assign(:author, build(:author, book_count: 3))
    render
    author.books.each do |book|
      expect(rendered).to have_content book.title
    end
  end

  it 'links to books' do
    author = assign(:author, build(:author, book_count: 3))
    render
    author.books.each do |book|
      expect(rendered).to have_link(nil, href: book_path(book))
    end
  end
end
