require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_db_column :payment_id }
  it { should have_db_column :billing_address_id }
  it { should have_db_column :shipment_address_id }
  it { should have_db_column :user_id }
  it { should have_db_column :shipment_id }

  it { should validate_presence_of :billing_address }
  it { should validate_presence_of :shipment_address }
  it { should validate_presence_of :user }
  it { should validate_presence_of :shipment }

  it { should have_many :order_items }

  it { should belong_to(:billing_address).class_name('Address') }
  it { should belong_to(:shipment_address).class_name('Address') }
  it { should belong_to :user }
  it { should belong_to :payment }
  it { should belong_to :shipment }

  describe '#add_order_items' do
    it 'Creates OrderItems from CartItems' do
      some_book = create(:book)
      cart = ShoppingCart.new
      3.times { cart.add(some_book) }
      order = Order.new

      order.add_order_items(cart)

      expect(order.order_items.first.book_id).to eq some_book.id
      expect(order.order_items.first.quantity).to eq 3
    end
  end

  describe '#create_order_billing_address' do
    it "makes a copy of user's billing_address" do
      order = Order.new
      order.user = build(:user)

      order.create_order_billing_address

      expect(order.billing_address.street_address)
        .to eq order.user.billing_address.street_address
    end
  end

  describe '#create_order_shipment_address' do
    it "makes a copy of user's delivery_address" do
      order = Order.new
      order.user = build(:user)

      order.create_order_shipment_address

      expect(order.shipment_address.street_address)
        .to eq order.user.delivery_address.street_address
    end
  end
end
