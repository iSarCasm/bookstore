require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe '#index' do
    it 'successfully renders page' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'sets @books' do
      books = create_list(:book, 2)
      get :index
      expect(assigns(:books)).to eq books
    end

    it 'sets @books' do
      categories = create_list(:category, 2)
      get :index
      expect(assigns(:categories)).to eq categories
    end
  end
end
