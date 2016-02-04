require 'rails_helper'

RSpec.describe 'routes for Orders', type: :routing do
  it "routes get '/orders/:id/edit_address' to Orders#edit_address" do
    expect(get('/orders/:id/edit_address')).to route_to(
      controller: 'orders',
      action: 'edit_address',
      id: ':id'
    )
  end

  it "routes get '/orders/:id/edit_delivery' to Orders#edit_address" do
    expect(get('/orders/:id/edit_delivery')).to route_to(
      controller: 'orders',
      action: 'edit_delivery',
      id: ':id'
    )
  end

  it "routes get '/orders/:id/edit_payment' to Orders#edit_address" do
    expect(get('/orders/:id/edit_payment')).to route_to(
      controller: 'orders',
      action: 'edit_payment',
      id: ':id'
    )
  end

  it "routes get '/orders/:id/confirm' to Orders#edit_address" do
    expect(get('/orders/:id/confirm')).to route_to(
      controller: 'orders',
      action: 'confirm',
      id: ':id'
    )
  end

  it "routes get '/orders/:id/complete' to Orders#edit_address" do
    expect(get('/orders/:id/complete')).to route_to(
      controller: 'orders',
      action: 'complete',
      id: ':id'
    )
  end
end
