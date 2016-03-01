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

  it "routes delete '/cart/clear' to Carts controller" do
    expect(delete('/cart/clear')).to route_to(
      controller: 'shopping_carts',
      action: 'clear'
    )
  end

  it "routes post '/cart/add' to Carts controller" do
    expect(post('/cart/add')).to route_to(
      controller: 'shopping_carts',
      action: 'add'
    )
  end

  it "routes post '/cart/checkout' to Carts controller" do
    expect(post('/cart/checkout')).to route_to(
      controller: 'shopping_carts',
      action: 'checkout'
    )
  end
end
