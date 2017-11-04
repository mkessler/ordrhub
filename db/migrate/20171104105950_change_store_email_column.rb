class ChangeStoreEmailColumn < ActiveRecord::Migration[5.0]
  def change
    change_column :stores, :email, :string, null: false, unique: true
  end
end
