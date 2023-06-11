# frozen_string_literal: true

class AddAssociateToCompany < ActiveRecord::Migration[7.0]
  def change
    change_table :companies do |t|
      t.references :flower_shop, foreign_key: true
    end
  end
end
