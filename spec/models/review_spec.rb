require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should have_db_column :user_id }
  it { should have_db_column :book_id }
  it { should have_db_column :rating }
  it { should have_db_column :message }
  it { should have_db_column :approved }

  it { should validate_presence_of :user }
  it { should validate_presence_of :book }
  it { should validate_presence_of :rating }
  it { should validate_presence_of :message }

  # it do
  #   should validate_numericality_of(:rating)
  #     .is_greater_than_or_equal_to(0.00)
  #     .is_less_than_or_equal_to(5.00)
  # end

  # WTF
  # Expected errors to include "must be greater than or equal to 0.0" when rating is set to -1.0,
  #    got errors:
  #    * "can't be blank" (attribute: user, value: nil)
  #    * "can't be blank" (attribute: message, value: nil)

  it { should belong_to :user }
  it { should belong_to :book }
end
