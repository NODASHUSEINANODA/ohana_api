# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  include Discard::Model

  belongs_to :order
  belongs_to :employee
  belongs_to :menu

  enum deliver_to: { company: 0, home: 1 }

  class << self
    def setup_next_order_detail(order_id, employee_id, menu_id)
      OrderDetail.create(
        order_id: order_id,
        employee_id: employee_id,
        menu_id: menu_id,
        deliver_to: 0,
        discarded_at: nil
      )
    end
  end
end
