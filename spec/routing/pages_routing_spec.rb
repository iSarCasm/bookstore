require 'rails_helper'

RSpec.describe 'routes for Pages', type: :routing do
  it "routes '/' to the pages controller" do
    expect(get('/')).to route_to(
      controller: 'pages',
      action: 'index'
    )
  end

  it "routes '/shop' to the pages controller" do
    expect(get('/shop')).to route_to(
      controller: 'pages',
      action: 'shop'
    )
  end
end
