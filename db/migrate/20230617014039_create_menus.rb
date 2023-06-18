# frozen_string_literal: true

class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.references :flower_shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
