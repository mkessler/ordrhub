class CreateLeads < ActiveRecord::Migration[5.0]
  def change
    create_table :leads do |t|
      t.string :email, null: false

      t.timestamps
    end
    add_index :leads, :email, unique: true
  end
end
