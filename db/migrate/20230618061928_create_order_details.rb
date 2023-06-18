# frozen_string_literal: true

class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.integer :deliver_to, null: false, default: 0 # デフォルトの 0 は 会社
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
