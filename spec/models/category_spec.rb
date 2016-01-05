require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_db_column :name }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it { should have_many(:books).through(:category_books)}
end
