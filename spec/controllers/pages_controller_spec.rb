require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe '#index' do
    it 'successfully renders page' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'sets @books to top 3 bestsellers' do
      create_list(:book, 10)
      get :index
      expect(assigns(:books)).to match_array Book.bestseller(3)
    end
  end

  describe '#shop' do
    it 'successfully renders page' do
      get :shop
      expect(response.status).to eq(200)
    end

    describe 'sets @books accordingly to category' do
      it 'when category: nil selects all books' do
        books = create_list(:book, 4)
        get :shop
        expect(assigns(:books)).to eq books
      end

      it 'when category: 1 selects books from that category' do
        create_list(:book, 1, categories: [build(:category, id: 0)])
        books = create_list(:book, 1, categories: [build(:category, id: 1)])
        get :shop, category: 1
        expect(assigns(:books)).to eq books
      end
    end


    it 'sets @categories' do
      categories = create_list(:category, 2)
      get :shop
      expect(assigns(:categories)).to eq categories
    end
  end
end
