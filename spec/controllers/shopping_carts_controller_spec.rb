require 'rails_helper'

RSpec.describe ShoppingCartsController, type: :controller do
  describe "#update" do
    before { request.env["HTTP_REFERER"] = index_url }

    it 'redirects back' do
      patch :update
      expect(response).to redirect_to :back
    end

    context 'when trying to add valid item' do
      it 'adds item to cart' do
        book = create(:book, id: 0)
        expect{patch :update, book: book}.to change{controller.current_cart.items}
      end
    end
  end
end
