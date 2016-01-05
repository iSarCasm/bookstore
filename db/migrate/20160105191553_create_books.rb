class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :desc
      t.float :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
