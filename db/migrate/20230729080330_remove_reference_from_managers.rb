# frozen_string_literal: true

class RemoveReferenceFromManagers < ActiveRecord::Migration[7.0]
  def change
    change_table :managers do |t|
      t.remove_references(:company)
    end
  end
end
