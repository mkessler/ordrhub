class AddOrderServicesToLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :grubhub, :boolean, null: false, default: false
    add_column :leads, :yelp, :boolean, null: false, default: false
    add_column :leads, :doordash, :boolean, null: false, default: false
    add_column :leads, :chownow, :boolean, null: false, default: false
  end
end
