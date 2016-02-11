class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.integer :rating
      t.text :message
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
