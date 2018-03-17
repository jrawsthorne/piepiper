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

ActiveRecord::Schema.define(version: 20180312223516) do

  create_table "account_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "item_type_id"
    t.integer "special_condition_id"
    t.index ["item_type_id"], name: "index_items_on_item_type_id"
    t.index ["special_condition_id"], name: "index_items_on_special_condition_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "item_id"
    t.integer "order_id"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "order_states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "order_state_id"
    t.index ["order_state_id"], name: "index_orders_on_order_state_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "special_conditions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_special_conditions", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "special_condition_id"
    t.integer "user_id"
    t.index ["special_condition_id"], name: "index_user_special_conditions_on_special_condition_id"
    t.index ["user_id"], name: "index_user_special_conditions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.string "password"
    t.string "twitter_id"
    t.string "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "account_type_id"
    t.index ["account_type_id"], name: "index_users_on_account_type_id"
  end

end
