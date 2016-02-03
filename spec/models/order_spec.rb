require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_db_column :payment_id }
  it { should have_db_column :billing_address_id }
  it { should have_db_column :shipment_address_id }
  it { should have_db_column :user_id }
  it { should have_db_column :shipment_id }

  it { should validate_presence_of :payment }
  it { should validate_presence_of :billing_address }
  it { should validate_presence_of :shipment_address }
  it { should validate_presence_of :user }
  it { should validate_presence_of :shipment }

  it { should belong_to(:billing_address).class_name('Address') }
  it { should belong_to(:shipment_address).class_name('Address') }
  it { should belong_to :user }
  it { should belong_to :payment }
  it { should belong_to :shipment }
end
