# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171113063044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "associations", id: :serial, force: :cascade do |t|
    t.integer "store_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id", "user_id"], name: "index_associations_on_store_id_and_user_id", unique: true
    t.index ["store_id"], name: "index_associations_on_store_id"
    t.index ["user_id"], name: "index_associations_on_user_id"
  end

  create_table "leads", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "grubhub", default: false, null: false
    t.boolean "yelp", default: false, null: false
    t.boolean "doordash", default: false, null: false
    t.boolean "chownow", default: false, null: false
    t.index ["email"], name: "index_leads_on_email", unique: true
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "user_id"], name: "index_memberships_on_organization_id_and_user_id", unique: true
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "store_id", null: false
    t.integer "source_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "details", default: {}
    t.string "number", null: false
    t.string "name"
    t.string "phone_number"
    t.index ["number", "store_id", "source_id"], name: "index_orders_on_number_and_store_id_and_source_id", unique: true
    t.index ["source_id"], name: "index_orders_on_source_id"
    t.index ["store_id"], name: "index_orders_on_store_id"
  end

  create_table "organizations", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sources", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", id: :serial, force: :cascade do |t|
    t.integer "organization_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.index ["email"], name: "index_stores_on_email", unique: true
    t.index ["organization_id"], name: "index_stores_on_organization_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "associations", "stores"
  add_foreign_key "associations", "users"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
  add_foreign_key "orders", "sources"
  add_foreign_key "orders", "stores"
  add_foreign_key "stores", "organizations"
end
