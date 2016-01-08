require 'rails_helper'

RSpec.describe 'routes for Carts', type: :routing do
  it "routes patch '/add-to-cart' to Carts controller" do
    expect(patch('/shopping_carts')).to route_to(
      controller: 'shopping_carts',
      action: 'update'
    )
  end
end
