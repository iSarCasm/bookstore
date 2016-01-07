require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe '#index' do
    it 'successfully renders page' do
      get :index
      expect(response.status).to eq(200)
    end

    describe 'sets @books accordingly to category' do
      it 'when category: nil selects all books' do
        books = create_list(:book, 4)
        get :index
        expect(assigns(:books)).to eq books
      end

      it 'when category: 1 selects books from that category' do
        create_list(:book, 1, categories: [build(:category, id: 0)])
        books = create_list(:book, 1, categories: [build(:category, id: 1)])
        get :index, category: 1
        expect(assigns(:books)).to eq books
      end
    end


    it 'sets @categories' do
      categories = create_list(:category, 2)
      get :index
      expect(assigns(:categories)).to eq categories
    end
  end
end
