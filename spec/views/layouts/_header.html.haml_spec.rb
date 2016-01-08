require 'rails_helper'

RSpec.describe "layouts/_header", type: :view, verify_stubs: false do
  before do
    # wtf
    cart = ShoppingCart.new
    allow(controller).to receive(:current_cart).and_return(cart)
  end

  # describe 'displays shopping cart' do
  #   it 'EMPTY when no items' do
  #     controller.current_cart.instance_variable_set(:@items, [])
  #     render
  #     expect(rendered).to have_content '(EMPTY)'
  #   end
  #
  #   it 'number of items when not empty' do
  #     controller.current_cart.instance_variable_set(:@items, [1,2,3])
  #     render
  #     expect(rendered).to have_content '(3)'
  #   end
  # end
end
