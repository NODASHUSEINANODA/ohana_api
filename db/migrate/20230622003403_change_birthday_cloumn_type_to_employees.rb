# frozen_string_literal: true

class ChangeBirthdayCloumnTypeToEmployees < ActiveRecord::Migration[7.0]
  def up
    change_table :employees do |t|
      t.remove :birthday
      t.date :birthday, null: false
    end
  end

  def down
    change_table :employees do |t|
      t.remove :birthday
      t.datetime :birthday, null: false
    end
  end
end
