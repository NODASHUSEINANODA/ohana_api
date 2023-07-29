# frozen_string_literal: true

class AddDiscardedAtToEmployees < ActiveRecord::Migration[7.0]
  def change
    change_table :employees do |t|
      t.datetime :discarded_at
      t.index :discarded_at
    end
  end
end
