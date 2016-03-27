class ChangeCvvtostring < ActiveRecord::Migration
  def change
    change_column :payment_infos, :cvv, :string
  end
end
