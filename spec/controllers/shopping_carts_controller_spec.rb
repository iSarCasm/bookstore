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
        expect(controller.current_cart).to receive(:add)
        patch :update, book: book
      end

      it 'adds coupon to cart' do
        coupon = create(:coupon)
        expect(controller.current_cart).to receive(:apply_coupon)
        patch :update, coupon: coupon
      end
    end
  end
end
