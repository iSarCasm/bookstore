require 'rails_helper'

RSpec.describe ShoppingCart do
  describe '.initialize' do
    it 'sets empty @items array' do
      expect(ShoppingCart.new.items).to eq []
    end
  end

  describe '#add' do
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
      3.times { cart.add(0) }
      2.times { cart.add(1) }
      expect(cart.size).to eq 5
    end
  end
end
