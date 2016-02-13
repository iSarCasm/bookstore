require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe '#show' do
    before {
      user = create(:user)
      sign_in user
      request.env["HTTP_REFERER"] = index_url
    }

    it 'creates and assigns @review' do
      book = create(:book)
      post :create, review: { message: "msg", rating: 5, book_id: book.id }
      expect(assigns(:review)).to_not eq nil
    end

    it 'redirects back' do
      book = create(:book)
      post :create, review: { message: "msg", rating: 5, book_id: book.id }
      expect(response).to redirect_to :back
    end
  end
end
