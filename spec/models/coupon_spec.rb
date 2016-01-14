require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :discount }

  it do
    should validate_numericality_of(:discount)
      .is_greater_than_or_equal_to(0.00)
      .is_less_than_or_equal_to(1.00)
  end
end
