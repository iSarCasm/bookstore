class CreatePaymentInfos < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|
      t.references :user, index: true, foreign_key: true
      t.string :card
      t.integer :expiration_year
      t.integer :expiration_month
      t.integer :cvv

      t.timestamps null: false
    end
  end
end
