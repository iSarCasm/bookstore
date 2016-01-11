require 'rails_helper'
RSpec.describe 'shopping_carts/show.html.haml', verify_stubs: false do
  before do
    cart = ShoppingCart.new
    stub_view(cart, :current_cart)
    allow(controller).to receive(:current_cart).and_return(cart)
    book_1 = create(:book, price: 10.00)
    book_2 = create(:book, price: 12.50)
    book_3 = create(:book, price: 20.00)
    3.times { controller.current_cart.add(book_1) }
    2.times { controller.current_cart.add(book_2) }
    1.times { controller.current_cart.add(book_3) }
  end

  it 'displays cart items titles' do
    render
    controller.current_cart.items.each do |item|
      expect(rendered).to have_content item.book.title
    end
  end

  it 'displays cart items quantity' do
    render
    controller.current_cart.items.each do |item|
      expect(rendered).to have_content item.quantity
    end
  end

  it 'displays cart items prices' do
    render
    controller.current_cart.items.each do |item|
      expect(rendered).to have_content (item.quantity * item.book.price)
    end
  end

  it 'displays cart total sum' do
    render
    controller.current_cart.items.each do |item|
      expect(rendered).to have_content 75
    end
  end
end
