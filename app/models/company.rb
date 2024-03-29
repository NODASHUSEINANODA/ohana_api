# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :managers, through: :employees
  has_many :orders, dependent: :destroy
  belongs_to :flower_shop

  validates :name, presence: true, length: { maximum: 100, allow_blank: true }
  validates :address, presence: true, length: { maximum: 100, allow_blank: true }

  # この:validatableはpasswordとemailしか検証してくれない
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  before_save :create_initial_order, if: :will_save_change_to_confirmed_at?

  class << self
    # 会社ごとの次回の注文情報(会社名と合計金額)
    def next_orders_company_name_and_amount
      Company.all.map do |company|
        next unless company.next_order

        {
          company_name: company.name,
          total_amount: company.next_order.calc_amount
        }
      end
    end

    # 次回の注文情報の合計金額
    def next_orders_total_amount
      total_amounts = Company.all.map do |company|
        next unless company.next_order

        company.next_order.calc_amount
      end

      total_amounts.sum
    end
  end

  def president
    managers.find_by(is_president: true)
  end

  def setup_next_order
    birthday_employee_ids = employees.birthday_within_two_months_later.pluck(:id)
    default_menu_id = flower_shop.cheapest_menu_of_the_season.id

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

  private

  def create_initial_order
    Order.create(company_id: id, flower_shop_id: flower_shop_id, total_amount: nil, ordered_at: nil)
  end
end
