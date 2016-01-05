class CreateCategoryBooks < ActiveRecord::Migration
  def change
    create_table :category_books do |t|
      t.references :book,     null: false
      t.references :category, null: false
      t.timestamps null: false
    end
  end
end
