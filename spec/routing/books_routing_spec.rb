require 'rails_helper'

RSpec.describe 'routes for Books', type: :routing do
  it "routes '/book/:id' to the books controller" do
    expect(get('/books/:id')).to route_to(
      controller: 'books',
      action: 'show',
      id: ':id'
    )
  end
end
