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

ActiveRecord::Schema[7.0].define(version: 2023_06_21_140302) do
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
    t.datetime "birthday", null: false
    t.string "address"
    t.string "phone_number"
    t.text "message"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "joined_at"
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "flower_shops", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "manager_id", null: false
    t.bigint "flower_shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_histories_on_employee_id"
    t.index ["flower_shop_id"], name: "index_histories_on_flower_shop_id"
    t.index ["manager_id"], name: "index_histories_on_manager_id"
  end

  create_table "managers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.string "email", null: false
    t.boolean "is_president", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "temporaries", charset: "utf8mb4", force: :cascade do |t|
    t.string "temporary_key", null: false
    t.bigint "manager_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_temporaries_on_employee_id"
    t.index ["manager_id"], name: "index_temporaries_on_manager_id"
  end

  add_foreign_key "companies", "flower_shops"
  add_foreign_key "employees", "companies"
  add_foreign_key "histories", "employees"
  add_foreign_key "histories", "flower_shops"
  add_foreign_key "histories", "managers"
  add_foreign_key "managers", "employees"
  add_foreign_key "menus", "flower_shops"
end
