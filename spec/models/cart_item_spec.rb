require 'rails_helper'

RSpec.describe CartItem do
  describe '#initialize' do
    it 'defines @id' do
      expect(CartItem.new(0).id).to eq 0
    end

    it 'defines @quantity' do
      expect(CartItem.new(0).quantity).to eq 1
    end
  end

  describe '#increase' do
    it 'increases @quantity by 1' do
      cart = CartItem.new(0)
      expect{cart.increase}.to change{cart.quantity}.by(1)
    end
  end
end
