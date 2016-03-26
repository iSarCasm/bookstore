class Addmoney < ActiveRecord::Migration
  def change
    add_monetize :books, :price
  end
end
