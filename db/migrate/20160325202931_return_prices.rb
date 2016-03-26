class ReturnPrices < ActiveRecord::Migration
  def change
    Book.find_each do |book|
      book.price = (10.50..60.30).step(0.01).to_a.sample
      book.save
    end
    remove_column :books, :old_price, :integer
  end
end
