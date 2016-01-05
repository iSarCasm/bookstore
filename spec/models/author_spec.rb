require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should have_db_column :name }
  it { should have_db_column :born }
  it { should have_db_column :country }
  it { should have_db_column :desc }
  it { should have_db_index :name }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it { should have_many(:books).through(:book_owns) }
end
