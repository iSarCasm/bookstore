require 'rails_helper'

RSpec.describe ShoppingCartsController, type: :controller do
  describe '#show' do
    it 'successfully responses' do
      get :show
      expect(response.status).to eq 200
    end
  end

  describe "#update" do
    before { request.env["HTTP_REFERER"] = index_url }

    it 'redirects back' do
      patch :update
      expect(response).to redirect_to :back
    end

    context 'when trying to add valid item' do
      it 'adds item to cart' do
        book = create(:book)
        expect{patch :update, book: book}.to change{controller.current_cart.items}
      end
    end
  end
end
