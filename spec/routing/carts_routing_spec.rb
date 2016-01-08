require 'rails_helper'

RSpec.describe 'routes for Carts', type: :routing do
  it "routes patch '/add-to-cart' to Carts controller" do
    expect(patch('/add-to-cart')).to route_to(
      controller: 'carts',
      action: 'add'
    )
  end
end
