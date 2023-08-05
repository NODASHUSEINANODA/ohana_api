class AddSeasonToMenu < ActiveRecord::Migration[7.0]
  def change
    change_table :menus do |t|
      t.integer :season, limit: 1
    end
  end
end
