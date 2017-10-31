class AddColumnsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :number, :string
    add_column :orders, :name, :string
    add_column :orders, :phone_number, :string
  end
end
