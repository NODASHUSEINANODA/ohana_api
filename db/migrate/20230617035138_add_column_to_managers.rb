# frozen_string_literal: true

class AddColumnToManagers < ActiveRecord::Migration[7.0]
  def change
    change_table :managers do |t|
      t.references :company, null: false
    end
  end
end
