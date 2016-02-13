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
      book = create(:book)
      expect{cart.add(book.id)}.to change{cart.items.size}
    end

    it 'accepts book model' do
      cart = ShoppingCart.new
      expect{cart.add(create(:book))}.to change{cart.items.size}
    end

    context 'when no items with this id' do
      it 'adds new CartItem' do
        cart = ShoppingCart.new
        book = create(:book)
        expect{cart.add(book.id)}.to change{cart.items.size}
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

  describe '#clear' do
    it 'resets the cart' do
      cart = ShoppingCart.new({
        cart: {"items" => ["id" => 0, "quantity" => 3, "coupon" => "LOL"] }
      })
      cart.clear
      expect(cart.items).to eq []
      expect(cart.coupon).to eq nil
    end
  end

  describe '#apply_coupon' do
    it 'accepts coupon.id' do
      cart = ShoppingCart.new
      coupon = create(:coupon)
      expect{cart.apply_coupon(coupon.name)}.to change{cart.coupon}
    end

    it 'accepts coupon model' do
      cart = ShoppingCart.new
      expect{cart.apply_coupon(create(:coupon))}.to change{cart.coupon}
    end
  end

  describe '#discount_string' do
    it 'returns discount string' do
      cart = ShoppingCart.new
      cart.apply_coupon(create(:coupon, discount: 0.1))
      expect(cart.discount_string).to eq '-10%'
    end
  end

  describe '#discount' do
    it 'returns discount' do
      cart = ShoppingCart.new
      cart.apply_coupon(create(:coupon, discount: 0.1))
      expect(cart.discount).to eq 0.1
    end
  end

  describe '#sum_without_discount' do
    it 'returns total price of all items' do
      cart = ShoppingCart.new
      cart.apply_coupon(create(:coupon, discount: 0.1))
      book_1 = create(:book, price: 10)
      book_2 = create(:book, price: 4)
      3.times { cart.add book_1 }
      2.times { cart.add book_2 }
      expect(cart.sum_without_discount).to eq 38
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
      cart.apply_coupon(create(:coupon, discount: 0.1))
      book_1 = create(:book, price: 10)
      3.times { cart.add book_1 }
      expect(cart.sum).to eq 27
    end
  end

  describe '#empty?' do
    it 'returns true when no items' do
      cart = ShoppingCart.new
      expect(cart).to be_empty
    end

    it 'returns false when any items' do
      cart = ShoppingCart.new({
        cart: {"items" => ["id" => 0, "quantity" => 3] }
      })
      expect(cart).to_not be_empty
    end
  end
end
