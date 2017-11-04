class AddEmailColumnToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :email, :string, unique: true
  end
end
