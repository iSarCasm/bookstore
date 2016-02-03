class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :name
      t.decimal :cost

      t.timestamps null: false
    end

    remove_column :orders, :shipment
    add_column :orders, :shipment_id, :integer
  end
end
