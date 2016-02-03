require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_db_column :payment_id }
  it { should have_db_column :billing_address_id }
  it { should have_db_column :shipment_address_id }
  it { should have_db_column :user_id }
  it { should have_db_column :shipment }

  it { should validate_presence_of :payment }
  it { should validate_presence_of :billing_address }
  it { should validate_presence_of :shipment_address }
  it { should validate_presence_of :user }
  it { should validate_presence_of :shipment }

  it "Shipment can only be one of selected types" do
    incorrect_order = build(:order, shipment: "by plane")
    expect(incorrect_order).to_not be_valid
    correct_order = build(:order, shipment: Order::SHIPMENT_TYPES.sample)
    expect(correct_order).to be_valid
  end

  it { should belong_to(:billing_address).class_name('Address') }
  it { should belong_to(:shipment_address).class_name('Address') }
  it { should belong_to :user }
  it { should belong_to :payment }
end
