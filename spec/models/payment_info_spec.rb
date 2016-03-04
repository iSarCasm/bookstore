require 'rails_helper'

RSpec.describe PaymentInfo, type: :model do
  it { should have_db_column :user_id }
  it { should have_db_column :card }
  it { should have_db_column :expiration_year }
  it { should have_db_column :expiration_month }
  it { should have_db_column :cvv }

  it { should validate_presence_of :user_id }
  it { should validate_presence_of :card }
  it { should validate_presence_of :expiration_year }
  it { should validate_presence_of :expiration_month }
  it { should validate_presence_of :cvv }

  it { should validate_numericality_of(:expiration_year)
        .is_greater_than_or_equal_to(2015)
        .is_less_than_or_equal_to(2100)}

  it { should validate_numericality_of(:expiration_month)
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(12)}

  it { should validate_length_of(:card).is_equal_to(16) }

  it 'factory payment is valid' do
    valid_payment = build(:payment_info)
    expect(valid_payment.valid?).to be_truthy
  end

  it 'validates card is digits only' do
    wrong_payment = build(:payment_info, card: "abcdabcdabcdabcd")
    expect(wrong_payment.valid?).to be_falsey
  end

  it 'validates cvv is 3 digits only' do
    wrong_payment = build(:payment_info, cvv: 4156)
    expect(wrong_payment.valid?).to be_falsey
    valid_payment = build(:payment_info, cvv: 415)
    expect(valid_payment.valid?).to be_truthy
  end


  it { should belong_to(:user) }
  it { should have_many(:orders) }
end
