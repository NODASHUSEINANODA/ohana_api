# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  belongs_to :flower_shop

  validates :name, presence: true, length: { maximum: 20, allow_blank: true }
  validates :address, presence: true, length: { maximum: 40, allow_blank: true }

  # この:validatableはpasswordとemailしか検証してくれない
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def next_month_order_to_flower_shop
    members = birthday_in_next_month_members

    return unless members.present?

    CompanyMailer.with(
      company_name: name,
      company_email: email,
      flower_shop_name: flower_shop.name,
      flower_shop_email: flower_shop.email,
      members: members
    ).order_to_flower_shop.deliver_now
  end

  private

  def birthday_in_next_month_members
    next_month = Time.zone.now.next_month.strftime('%m')
    birthday_in_next_month_condition = Employee.arel_table[:birthday].extract('month').eq(next_month)
    employees.where(birthday_in_next_month_condition)
  end
end
