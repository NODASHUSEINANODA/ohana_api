# frozen_string_literal: true

class AddAssociateToCompany < ActiveRecord::Migration[7.0]
  def change
    change_table :flower_shops do |t|
      t.references :company, foreign_key: true
    end
  end
end
