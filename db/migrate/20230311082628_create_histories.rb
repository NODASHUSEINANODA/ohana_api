class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :manager, null: false, foreign_key: true
      t.references :flower_shop, null: false, foreign_key: true
      t.timestamps
    end
  end
end
