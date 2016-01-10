class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :country
      t.string :zip
      t.string :phone

      t.timestamps null: false
    end

    add_column :users, :billing_address_id, :integer
    add_column :users, :delivery_address_id, :integer
  end
end
