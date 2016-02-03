class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :payment
      t.integer :billing_address_id, index: true, foreign_key: true
      t.integer :shipment_address_id, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :shipment

      t.timestamps null: false
    end
  end
end
