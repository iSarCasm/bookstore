require 'rails_helper'

RSpec.describe 'routes for Checkouts', type: :routing do
  it "routes get '/checkouts/:id/edit_address' to Orders#edit_address" do
    expect(get('/checkouts/:id/edit_address')).to route_to(
      controller: 'checkouts',
      action: 'edit_address',
      id: ':id'
    )
  end

  it "routes get '/checkouts/:id/edit_delivery' to Orders#edit_delivery" do
    expect(get('/checkouts/:id/edit_delivery')).to route_to(
      controller: 'checkouts',
      action: 'edit_delivery',
      id: ':id'
    )
  end

  it "routes get '/checkouts/:id/edit_payment' to Orders#edit_payment" do
    expect(get('/checkouts/:id/edit_payment')).to route_to(
      controller: 'checkouts',
      action: 'edit_payment',
      id: ':id'
    )
  end

  it "routes get '/checkouts/:id/confirm' to Orders#confirm" do
    expect(get('/checkouts/:id/confirm')).to route_to(
      controller: 'checkouts',
      action: 'confirm',
      id: ':id'
    )
  end

  it "routes patch '/checkouts/:id' to Orders#update" do
    expect(patch('/checkouts/:id')).to route_to(
      controller: 'checkouts',
      action: 'update',
      id: ':id'
    )
  end

  it "routes post '/checkouts/:id/place' to Orders#place" do
    expect(post('/checkouts/:id/place')).to route_to(
      controller: 'checkouts',
      action: 'place',
      id: ':id'
    )
  end
end
