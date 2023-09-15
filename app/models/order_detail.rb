# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  include Discard::Model

  belongs_to :order
  belongs_to :employee
  belongs_to :menu

  scope :order_by_birthday, -> { joins(:employee).order('employees.birthday asc') }

  enum deliver_to: { company: 0, home: 1 }

  class << self
    def setup_next_order_detail(order_id, employee_id, menu_id)
      employee_name = Employee.find(employee_id).name
      OrderDetail.create(
        order_id: order_id,
        employee_id: employee_id,
        menu_id: menu_id,
        deliver_to: 0,
        discarded_at: nil,
        birthday_message: "#{employee_name}さん、お誕生日おめでとうございます！"
      )
    end
  end

  def prepare_for_company_mailer
    {
      employee_name: employee.name,
      employee_birthday: employee.birthday_format_mm_dd,
      delivery_address: delivery_address,
      menu_name_with_price: menu.name_with_price
    }
  end

  def delivery_address
    return employee.address if employee.address && deliver_to == 'home'

    employee.company.address
  end
end
