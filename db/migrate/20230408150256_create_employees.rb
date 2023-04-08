class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :sex, null: false
      t.datetime :birthday, null: false
      t.string :address, null: false
      t.integer :work_year, null: false
      t.string :phone_number, null: false
      t.text :message, null: false
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end

