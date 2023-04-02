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

ActiveRecord::Schema[7.0].define(version: 2023_04_02_142423) do
  create_table "companies", charset: "utf8mb4", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "name"
    t.string "address"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_companies_on_address", unique: true
    t.index ["confirmation_token"], name: "index_companies_on_confirmation_token", unique: true
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_companies_on_uid_and_provider", unique: true
  end

  create_table "employees", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "sex", null: false
    t.datetime "birthday", null: false
    t.string "address", null: false
    t.integer "work_year", null: false
    t.string "phone_number", null: false
    t.text "message", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.boolean "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_managers_on_employee_id"
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

  add_foreign_key "employees", "companies"
  add_foreign_key "histories", "employees"
  add_foreign_key "histories", "flower_shops"
  add_foreign_key "histories", "managers"
  add_foreign_key "managers", "employees"
end
