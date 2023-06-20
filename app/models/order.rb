# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_details
  belongs_to :company
  belongs_to :flower_shop

  class << self
    def setup_next_order(company_id, flower_shop_id, birthday_employee_ids, default_menu_id)
      ActiveRecord::Base.transaction do
        next_order = Order.create(
          company_id: company_id,
          flower_shop_id: flower_shop_id
        )

        birthday_employee_ids.each do |employee_id|
          OrderDetail.setup_next_order_detail(next_order.id, employee_id, default_menu_id)
        end
      end
    end
  end
end
