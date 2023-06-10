class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_one :flower_shop

  validates :name, presence: true, length: { maximum: 20, allow_blank: true }
  validates :address, presence: true, length: { maximum: 20, allow_blank: true }

  # この:validatableはpasswordとemailしか検証してくれない
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def current_month_order_to_flower_shop
    members = self.birthday_in_current_month_members

    CompanyMailer.with(
      company_name: self.name,
      company_email: self.email,
      flower_shop_name: self.flower_shop.name,
      flower_shop_email: self.flower_shop.email,
      members: members,
    ).order_to_flower_shop.deliver_now if members.present?
  end

  private

  def birthday_in_current_month_members
    current_month = Time.zone.now.strftime("%m")
    birthday_in_current_month_condition = Employee.arel_table[:birthday].extract('month').eq(current_month)
    employees.where(birthday_in_current_month_condition)
  end
end
