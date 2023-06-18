# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :company
  has_one :manager
  has_many :histories, dependent: :destroy
  has_many :temporaries, dependent: :destroy

  validates :name, :sex, :birthday, :address, :joined_at, :phone_number, :company_id, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/ } # 電話番号は10桁or11桁の数字のみ

  scope :birthdays_in_next_month, -> {
    next_month = Time.zone.now.next_month.strftime('%m')
    birthday_in_next_month_condition = Employee.arel_table[:birthday].extract('month').eq(next_month)
    where(birthday_in_next_month_condition)
  }

  def save_with_manager(email, is_president)
    transaction do
      save!
      manager = Manager.new(employee_id: id, email: email, is_president: is_president)
      manager.save!
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
end
