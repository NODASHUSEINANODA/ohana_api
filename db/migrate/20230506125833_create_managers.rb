class CreateManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :managers do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :email, null: false
      t.boolean :status, null: false
      t.timestamps
    end
  end
end
