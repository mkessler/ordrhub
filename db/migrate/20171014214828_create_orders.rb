class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :store, foreign_key: true, null: false
      t.references :source, foreign_key: true, null: false

      t.timestamps
    end
  end
end
