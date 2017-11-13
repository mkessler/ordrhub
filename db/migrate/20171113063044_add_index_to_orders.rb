class AddIndexToOrders < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :number, :string, null: false
    add_index :orders, [:number, :store_id, :source_id], unique: true
  end
end
