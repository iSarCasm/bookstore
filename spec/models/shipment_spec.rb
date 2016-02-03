require 'rails_helper'

RSpec.describe Shipment, type: :model do
  it { should have_db_column :name }
  it { should have_db_column :cost }

  it { should validate_presence_of :name }
  it { should validate_presence_of :cost }

  it { should validate_numericality_of(:cost).is_greater_than(0) }

  it { should have_many(:orders) }
end
