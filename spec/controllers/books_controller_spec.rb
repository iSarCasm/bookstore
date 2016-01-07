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
    end

    context 'when book not found' do
      it 'redirect to 404' do
        get :show, id: 1
        expect(response.status).to eq(404)
      end
    end
  end
end
