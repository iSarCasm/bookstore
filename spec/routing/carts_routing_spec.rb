require 'rails_helper'

RSpec.describe 'routes for Carts', type: :routing do
  it "routes get '/cart' to Carts#show" do
    expect(get('/cart')).to route_to(
      controller: 'shopping_carts',
      action: 'show'
    )
  end

  it "routes patch '/cart' to Carts controller" do
    expect(patch('/cart')).to route_to(
      controller: 'shopping_carts',
      action: 'update'
    )
  end

  it "routes post '/cart' to Carts controller" do
    expect(post('/cart')).to route_to(
      controller: 'shopping_carts',
      action: 'checkout'
    )
  end
end
