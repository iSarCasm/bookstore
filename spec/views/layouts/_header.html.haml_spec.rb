require 'rails_helper'

RSpec.describe "layouts/_header", type: :view, verify_stubs: false do
  def stub_view(mock, method = :current_cart)
    allow_any_instance_of(ActionView::Base).to receive(method).and_return(mock)
  end

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
end
