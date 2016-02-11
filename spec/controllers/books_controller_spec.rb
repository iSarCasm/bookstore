require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe '#show' do
    context 'when book found' do
      it 'successfully renders page' do
        create(:book, id: 1)
        get :show, id: 1
        expect(response.status).to eq(200)
      end

      it 'assigns @book' do
        book = create(:book, id: 1)
        get :show, id: 1
        expect(assigns(:book)).to eq book
      end

      it 'assigns @reviews approved reviews' do
        book = create(:book, id: 1)
        reviews = create_list(:review, 3, book: book)
        approved_reviews = create_list(:review, 2, book: book, approved: true)
        get :show, id: 1
        expect(assigns(:reviews)).to eq approved_reviews
      end
    end
  end
end
