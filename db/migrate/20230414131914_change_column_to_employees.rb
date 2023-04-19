# frozen_string_literal: true

# work_yearのようにintではなく、date型で管理できるように修正(インクリメントさせる必要がないため)
class ChangeColumnToEmployees < ActiveRecord::Migration[7.0]
  def change
    change_table :employees do |t|
      t.remove :work_year, type: :integer
      t.date :joined_at
    end
  end
end
