require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should have_db_column :first_name }
  it { should have_db_column :last_name }
  it { should have_db_column :street_address }
  it { should have_db_column :city }
  it { should have_db_column :country }
  it { should have_db_column :zip }
  it { should have_db_column :phone }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :street_address }
  it { should validate_presence_of :city }
  it { should validate_presence_of :country }
  it { should validate_presence_of :zip }
  it { should validate_presence_of :phone }
end
