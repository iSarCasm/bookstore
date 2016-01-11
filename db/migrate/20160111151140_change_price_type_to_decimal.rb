class ChangePriceTypeToDecimal < ActiveRecord::Migration
  def change
    change_column :books, :price, :decimal
  end
end
