# frozen_string_literal: true

class RenameStatusInManager < ActiveRecord::Migration[7.0]
  def change
    change_table :managers do |t|
      t.rename(:status, :is_president)
    end
  end
end
