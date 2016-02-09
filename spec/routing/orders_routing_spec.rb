require 'rails_helper'

RSpec.describe 'routes for Orders', type: :routing do
  it "routes get '/orders/:id/edit_address' to Orders#edit_address" do
    expect(get('/orders/:id/edit_address')).to route_to(
      controller: 'orders',
      action: 'edit_address',
      id: ':id'
    )
  end

  it "routes get '/orders/:id/edit_delivery' to Orders#edit_delivery" do
    expect(get('/orders/:id/edit_delivery')).to route_to(
      controller: 'orders',
      action: 'edit_delivery',
      id: ':id'
    )
  end

  it "routes get '/orders/:id/edit_payment' to Orders#edit_payment" do
    expect(get('/orders/:id/edit_payment')).to route_to(
      controller: 'orders',
      action: 'edit_payment',
      id: ':id'
    )
  end

  it "routes get '/orders/:id/confirm' to Orders#confirm" do
    expect(get('/orders/:id/confirm')).to route_to(
      controller: 'orders',
      action: 'confirm',
      id: ':id'
    )
  end

  it "routes get '/orders/:id' to Orders#show" do
    expect(get('/orders/:id')).to route_to(
      controller: 'orders',
      action: 'show',
      id: ':id'
    )
  end

  it "routes patch '/orders/:id' to Orders#update" do
    expect(patch('/orders/:id')).to route_to(
      controller: 'orders',
      action: 'update',
      id: ':id'
    )
  end

  it "routes post '/orders/:id/place' to Orders#place" do
    expect(post('/orders/:id/place')).to route_to(
      controller: 'orders',
      action: 'place',
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
