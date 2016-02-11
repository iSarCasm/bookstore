require 'rails_helper'

RSpec.describe 'routes for Reviews', type: :routing do
  it "routes POST '/reviews' to the reviews controller" do
    expect(post('/reviews')).to route_to(
      controller: 'reviews',
      action: 'create'
    )
  end
end
