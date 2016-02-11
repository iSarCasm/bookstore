require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_db_column :email }
  it { should have_db_column :encrypted_password }
  it { should have_db_column :reset_password_token }
  it { should have_db_column :reset_password_sent_at }
  it { should have_db_column :remember_created_at }
  it { should have_db_column :sign_in_count }
  it { should have_db_column :current_sign_in_at }
  it { should have_db_column :last_sign_in_at }
  it { should have_db_column :current_sign_in_ip }
  it { should have_db_column :last_sign_in_ip }
  it { should have_db_column :confirmation_token }
  it { should have_db_column :confirmed_at }
  it { should have_db_column :confirmation_sent_at }
  it { should have_db_column :unconfirmed_email }

  it { should belong_to(:billing_address).class_name('Address') }
  it { should belong_to(:delivery_address).class_name('Address') }
  it { should have_many(:payments).class_name('PaymentInfo') }
  it { should have_many(:orders) }
  it { should have_many(:reviews) }
end
