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

    it 'adds coupon to cart' do
      coupon = create(:coupon)
      expect(controller.current_cart).to receive(:apply_coupon)
      patch :update, coupon: coupon
    end
  end

  describe '#checkout' do
    context 'when signed in' do
      it 'creates new order' do
        sign_in create(:user)
        expect(Order).to receive(:create_from_cart).and_return(create(:order))
        post :checkout
      end
    end

    context 'when guest' do
      it 'redirects to sign in' do
        post :checkout
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#clear' do
    it 'redirects back to cart page' do
      patch :clear
      expect(response).to redirect_to shopping_carts_path
    end

    it 'clears cart' do
      cart = ShoppingCart.new({
        cart: {"items" => ["id" => 0, "quantity" => 3] }
      })
      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart)
      patch :clear
      expect(cart).to be_empty
    end
  end
end
