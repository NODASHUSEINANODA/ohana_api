# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_29_052624) do
  create_table "companies", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "flower_shop_id"
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["flower_shop_id"], name: "index_companies_on_flower_shop_id"
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "employees", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "sex", null: false
    t.string "address"
    t.string "phone_number"
    t.text "message"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "joined_at"
    t.date "birthday", null: false
    t.datetime "discarded_at"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["discarded_at"], name: "index_employees_on_discarded_at"
  end

  create_table "flower_shops", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.string "email", null: false
    t.boolean "is_president", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_managers_on_company_id"
    t.index ["employee_id"], name: "index_managers_on_employee_id"
  end

  create_table "menus", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.bigint "flower_shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flower_shop_id"], name: "index_menus_on_flower_shop_id"
  end

  create_table "order_details", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "employee_id", null: false
    t.integer "deliver_to", default: 0, null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_order_details_on_discarded_at"
    t.index ["employee_id"], name: "index_order_details_on_employee_id"
    t.index ["menu_id"], name: "index_order_details_on_menu_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
  end

  create_table "orders", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "flower_shop_id", null: false
    t.integer "total_amount"
    t.datetime "ordered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_orders_on_company_id"
    t.index ["flower_shop_id"], name: "index_orders_on_flower_shop_id"
  end

  add_foreign_key "companies", "flower_shops"
  add_foreign_key "employees", "companies"
  add_foreign_key "managers", "employees"
  add_foreign_key "menus", "flower_shops"
  add_foreign_key "order_details", "employees"
  add_foreign_key "order_details", "menus"
  add_foreign_key "order_details", "orders"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "flower_shops"
end
