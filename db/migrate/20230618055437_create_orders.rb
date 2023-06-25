# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :company, null: false, foreign_key: true
      t.references :flower_shop, null: false, foreign_key: true
      t.integer :total_amount
      t.datetime :ordered_at

      t.timestamps
    end
  end
end
