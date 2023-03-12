class CreateTemporaries < ActiveRecord::Migration[7.0]
  def change
    create_table :temporaries do |t|
      t.string :temporary_key, null: false
      t.references :manager, null: false
      t.references :employee, null: false
      t.timestamps
    end
  end
end
