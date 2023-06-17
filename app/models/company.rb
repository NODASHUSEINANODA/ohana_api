# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :managers, dependent: :destroy
  belongs_to :flower_shop

  validates :name, presence: true, length: { maximum: 20, allow_blank: true }
  validates :address, presence: true, length: { maximum: 40, allow_blank: true }

  # この:validatableはpasswordとemailしか検証してくれない
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def president
    managers.find_by(status: true)
  end

  def next_month_order_to_flower_shop
    members = employees_with_birthdays_next_month

    return unless members.present?

    CompanyMailer.with(
      company_name: name,
      company_email: email,
      flower_shop_name: flower_shop.name,
      flower_shop_email: flower_shop.email,
      members: members
    ).order_to_flower_shop.deliver_now
  end

  def employees_with_birthdays_next_month
    employees.birthdays_in_next_month
  end
end
