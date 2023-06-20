# frozen_string_literal: true

class AddDiscardedAtToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    change_table :order_details do |t|
      t.datetime :discarded_at
      t.index :discarded_at
    end
  end
end
