class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.references :organization, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
