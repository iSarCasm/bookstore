require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should have_db_column :order_id }
  it { should have_db_column :book_id }
  it { should have_db_column :quantity }

  it { should validate_presence_of :order }
  it { should validate_presence_of :book }
  it { should validate_presence_of :quantity }

  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }

  it { should belong_to(:order) }
end
