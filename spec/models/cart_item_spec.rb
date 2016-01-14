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

  describe '#book' do
    it 'returns book object of current @id' do
      book = create(:book)
      item = CartItem.new(book.id)
      expect(item.book).to eq book
    end
  end

  describe '#sum' do
    it 'returns total price of item' do
      book = create(:book, price: 10.00)
      item = CartItem.new(book.id)
      2.times { item.increase }
      expect(item.sum).to eq 30
    end
  end

  describe '#price' do
    it 'return signle item price' do
      book = create(:book, price: 10.00)
      item = CartItem.new(book.id)
      2.times { item.increase }
      expect(item.price).to eq 10
    end
  end

  describe '#title' do
    it 'return signle item price' do
      book = create(:book, title: 'lel')
      item = CartItem.new(book.id)
      expect(item.title).to eq 'lel'
    end
  end

  describe '#increase' do
    it 'increases @quantity by 1' do
      item = CartItem.new(0)
      expect{item.increase}.to change{item.quantity}.by(1)
    end
  end
end
