require 'rails_helper'

RSpec.describe 'routes for Orders', type: :routing do
  it "routes get '/orders/:id' to Orders#show" do
    expect(get('/orders/:id')).to route_to(
      controller: 'orders',
      action: 'show',
      id: ':id'
    )
  end

  it "routes post '/orders' to Orders#index" do
    expect(get('/orders')).to route_to(
      controller: 'orders',
      action: 'index'
    )
  end
end
