# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :managers, dependent: :destroy
  has_many :orders
  belongs_to :flower_shop

  validates :name, presence: true, length: { maximum: 20, allow_blank: true }
  validates :address, presence: true, length: { maximum: 40, allow_blank: true }

  # この:validatableはpasswordとemailしか検証してくれない
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def president
    managers.find_by(is_president: true)
  end

  def setup_next_order
    birthday_employee_ids = employees_with_birthdays_next_month.pluck(:id)
    default_menu_id = flower_shop.cheapest_menu.id

    Order.setup_next_order(id, flower_shop.id, birthday_employee_ids, default_menu_id)
  end

  def next_order
    orders.where(ordered_at: nil).order(created_at: :desc).first
  end

  def next_order_details
    next_order.order_details.kept.order_by_birthday
  end

  # formatted_next_ordersは、OrderDetailのprepare_for_company_mailerメソッドの返り値を指定
  def order_to_flower_shop(formatted_next_orders)
    CompanyMailer.with(
      company_name: name,
      company_email: email,
      flower_shop_name: flower_shop.name,
      flower_shop_email: flower_shop.email,
      next_orders_info: formatted_next_orders,
      total_amount: next_order.calc_amount
    ).order_to_flower_shop.deliver_now
  end

  def no_order_to_flower_shop
    CompanyMailer.with(
      company_name: name,
      company_email: email,
      flower_shop_name: flower_shop.name,
      flower_shop_email: flower_shop.email
    ).no_order_to_flower_shop.deliver_now
  end

  def employees_with_birthdays_next_month
    employees.birthdays_in_next_month
  end
end
