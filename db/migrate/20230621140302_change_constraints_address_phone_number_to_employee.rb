# frozen_string_literal: true

class ChangeConstraintsAddressPhoneNumberToEmployee < ActiveRecord::Migration[7.0]
  def change
    change_table :employees do |t|
      t.change_null(:address, true)
      t.change_null(:phone_number, true)
    end
  end
end
