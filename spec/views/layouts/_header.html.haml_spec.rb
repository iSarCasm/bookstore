require 'rails_helper'

RSpec.describe "layouts/_header", type: :view, verify_stubs: false do
  describe 'displays shopping cart' do
    it 'EMPTY when no items' do
      cart = ShoppingCart.new
      stub_view(cart)
      render
      expect(rendered).to have_content '(EMPTY)'
    end

    it 'number of items when not empty' do
      cart = ShoppingCart.new
      3.times { cart.add(0) }
      stub_view(cart)
      render
      expect(rendered).to have_content '(3 items)'
    end
  end

  describe 'displays Login status' do
    before { stub_view(ShoppingCart.new) }

    context 'when user signed out' do
      it "shows 'sign in' link" do
        render
        expect(rendered).to have_link 'Sign In'
      end

      it "it shows 'sign up' link" do
        render
        expect(rendered).to have_link 'Sign Up'
      end
    end

    context 'when user signed in' do
      it "shows 'Orders' link" do
        sign_in create(:user)
        render
        expect(rendered).to have_link nil, href: orders_path
      end

      it 'shows "Settings" link' do
        sign_in create(:user)
        render
        expect(rendered).to have_link nil, href: edit_user_registration_path
      end

      it "shows 'sign out' link" do
        sign_in create(:user)
        render
        expect(rendered).to have_link nil, href: destroy_user_session_path
      end
    end
  end
end
