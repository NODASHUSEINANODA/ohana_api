class ChangeColumnToEmployees < ActiveRecord::Migration[7.0]
  def change
    change_table :employees do |t|
      t.remove :work_year, type: :integer
      t.date :joined_at
    end
  end
end
