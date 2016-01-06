require 'rails_helper'

RSpec.describe 'routes for Authors', type: :routing do
  it "it routes '/authors/:id' to authors controller" do
    expect(get('/authors/:id')).to route_to(
      controller: 'authors',
      action: 'show',
      id: ':id'
    )
  end
end
