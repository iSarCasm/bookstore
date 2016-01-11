require 'rails_helper'

RSpec.describe ShoppingCart do
  describe '.initialize' do
    it 'sets empty @items array' do
      expect(ShoppingCart.new.items).to eq []
    end
  end

  describe '#add' do
    it 'accepts book.id' do
      cart = ShoppingCart.new
      expect{cart.add(0)}.to change{cart.items.size}
    end

    it 'accepts book model' do
      cart = ShoppingCart.new
      expect{cart.add(create(:book))}.to change{cart.items.size}
    end

    context 'when no items with this id' do
      it 'adds new CartItem' do
        cart = ShoppingCart.new
        expect{cart.add(0)}.to change{cart.items.size}
      end
    end

    context 'when there is already item of this id' do
      it 'increases quantity of this CartItem' do
        cart = ShoppingCart.new({
          cart: {"items" => ["id" => 0, "quantity" => 3] }
        })
        expect{cart.add(0)}.not_to change{cart.items.size}
        expect{cart.add(0)}.to change{cart.items.last.quantity}
      end
    end
  end

  describe '#size' do
    it 'returns total number of items in cart' do
      cart = ShoppingCart.new
      book_1 = create(:book)
      book_2 = create(:book)
      3.times { cart.add(book_1) }
      2.times { cart.add(book_2) }
      expect(cart.size).to eq 5
    end
  end

  describe '#sum' do
    it 'returns total price of all items' do
      cart = ShoppingCart.new
      book_1 = create(:book, price: 10)
      book_2 = create(:book, price: 4)
      3.times { cart.add book_1 }
      2.times { cart.add book_2 }
      expect(cart.sum).to eq 38
    end
  end
end
