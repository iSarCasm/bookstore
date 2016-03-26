class AddMonetize < ActiveRecord::Migration
  def change
    prices = {}
    Book.find_each do |book|
      prices[book.id] = book.price
    end

    remove_column :books, :price
    remove_column :books, :price_currency
    add_column :books, :old_price, :decimal
    

    Book.find_each do |book|
      book.old_price = prices[book.id]
    end
  end
end
