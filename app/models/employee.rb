# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :company
  has_one :manager
  has_many :order_details

  validates :name, :sex, :birthday, :joined_at, :company_id, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }, allow_nil: true # 電話番号は10桁or11桁の数字のみ
  validate :require_phune_number_if_address_exist

  scope :birthdays_in_next_month, lambda {
    next_month = Time.zone.now.next_month.strftime('%m')
    birthday_in_next_month_condition = Employee.arel_table[:birthday].extract('month').eq(next_month)

    where(birthday_in_next_month_condition).order(birthday: :asc)
  }

  def require_phune_number_if_address_exist
    errors.add(:phone_number, 'を入力してください') if address.present? && phone_number.blank?
  end

  def save_with_manager(email, is_president)
    transaction do
      save!
      manager = Manager.new(employee_id: id, email: email, is_president: is_president, company_id: company_id)
      manager.save!
    end
  end

  def save_with_order_detail(current_company)
    transaction do
      save!
      order_detail = OrderDetail.new(
        order_id: current_company.next_order.id,
        employee_id: id,
        menu_id: current_company.flower_shop.cheapest_menu.id,
        deliver_to: 0,
        discarded_at: nil
      )
      order_detail.save!
    end
  end

  def destroy_with_manager
    transaction do
      manager.destroy!
      destroy!
    end
  end

  # YYYY年MM月DD日の形式で誕生日を返す
  def birthday_format_yyyy_mm_dd
    birthday.strftime('%Y年%m月%d日')
  end

  # MM月DD日の形式で誕生日を返す
  def birthday_format_mm_dd
    birthday.strftime('%m月%d日')
  end

  def age
    now = Date.today.year
    now - birthday.year
  end

  # 勤続年数を返す(joined_atから現在までの年数)
  def working_years
    now = Date.today
    diff_years = now.year - joined_at.year

    is_earlier_todays_date = now.month < joined_at.month || (now.month == joined_at.month && now.day < joined_at.day)

    diff_years -= 1 if is_earlier_todays_date

    diff_years
  end

  def birthday_is_next_month?
    next_month = Time.zone.now.next_month.strftime('%m').to_i
    return true if birthday.month == next_month

    false
  end
end
