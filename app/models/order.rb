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

    # 運営会社へ今月の注文から会社名と合計金額を取得し送信
    def amount_of_sales_to_operating_company
      orders_info = Company.next_orders_company_name_and_amount
      total_amount = Company.next_orders_total_amount

      OrderMailer.with(
        orders_info: orders_info,
        total_amount: total_amount
      ).amount_of_sales_to_operating_company.deliver_now
    end
  end

  def calc_amount
    order_details.kept.map { |detail| detail.menu.price }.sum
  end

  # formatted_next_ordersは、OrderDetailのprepare_for_company_mailerメソッドの返り値を指定
  def shipping_confirmation_to_president(formatted_next_orders)
    president = my_president
    manager_emails = my_managers.pluck(:email)

    OrderMailer.with(
      president_name: president.employee.name,
      president_email: president.email,
      manager_emails: manager_emails,
      company_email: company.email,
      next_orders_info: formatted_next_orders,
      total_amount: calc_amount
    ).shipping_confirmation_to_president.deliver_now
  end

  def no_shipping_confirmation_to_president
    president = my_president
    manager_emails = my_managers.pluck(:email)

    OrderMailer.with(
      president_name: president.employee.name,
      president_email: president.email,
      manager_emails: manager_emails,
      company_email: company.email
    ).no_shipping_confirmation_to_president.deliver_now
  end

  private

  def my_president
    company.president
  end

  def my_managers
    company.managers.not_presidents
  end
end
