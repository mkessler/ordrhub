class AddStoreEmailUniqueIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :stores, :email, unique: true
  end
end
