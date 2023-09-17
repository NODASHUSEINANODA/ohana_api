class AddBirthdayMessageToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    change_table :order_details do |t|
      t.text :birthday_message
    end
  end
end
