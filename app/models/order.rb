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

  def calc_amount
    order_details.kept.map { |detail| detail.menu.price }.sum
  end

  # formatted_next_ordersは、OrderDetailのprepare_for_company_mailerメソッドの返り値を指定
  def shipping_confirmation_to_president(formatted_next_orders)
    president = company.president

    OrderMailer.with(
      president_name: president.employee.name,
      president_email: president.email,
      next_orders_info: formatted_next_orders
    ).shipping_confirmation_to_president.deliver_now
  end

  def no_shipping_confirmation_to_president
    president = company.president

    OrderMailer.with(
      president_name: president.employee.name,
      president_email: president.email,
    ).no_shipping_confirmation_to_president.deliver_now
  end
end
