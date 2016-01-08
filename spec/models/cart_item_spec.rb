require 'rails_helper'

RSpec.describe CartItem do
  describe '.initialize' do
    it 'defines @id' do
      expect(CartItem.new(0).id).to eq 0
    end

    it 'defines @quantity' do
      expect(CartItem.new(0).quantity).to eq 1
    end
  end

  describe '.restore' do
    it 'restores CartItem from hash' do
      item = CartItem.restore({"id" => 1, "quantity" => 3})
      expect(item).to be_instance_of CartItem
    end
  end

  describe '#increase' do
    it 'increases @quantity by 1' do
      cart = CartItem.new(0)
      expect{cart.increase}.to change{cart.quantity}.by(1)
    end
  end
end
