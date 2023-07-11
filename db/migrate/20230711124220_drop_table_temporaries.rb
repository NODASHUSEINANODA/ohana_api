class DropTableTemporaries < ActiveRecord::Migration[7.0]
  def change
    drop_table :temporaries
  end
end
