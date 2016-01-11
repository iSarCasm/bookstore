require 'rails_helper'

RSpec.describe 'routes for Carts', type: :routing do
  it "routes get '/cart' to Carts#show" do
    expect(get('/cart')).to route_to(
      controller: 'shopping_carts',
      action: 'show'
    )
  end

  it "routes patch '/add-to-cart' to Carts controller" do
    expect(patch('/shopping_carts')).to route_to(
      controller: 'shopping_carts',
      action: 'update'
    )
  end
end
