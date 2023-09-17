# frozen_string_literal: true

class Employee < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }
  belongs_to :company
  has_one :manager, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :name, :sex, :birthday, :joined_at, :company_id, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }, allow_nil: true, allow_blank: true # 電話番号は10桁or11桁の数字のみ
  validate :require_phune_number_if_address_exist

  scope :birthdays_in_next_month, lambda {
    next_month = Time.zone.now.next_month.strftime('%m')
    birthday_in_next_month_condition = Employee.arel_table[:birthday].extract('month').eq(next_month)

    where(birthday_in_next_month_condition).order(birthday: :asc)
  }

  scope :order_manager_is_president_desc, lambda {
    left_joins(:manager).order('managers.is_president DESC')
  }

  def require_phune_number_if_address_exist
    errors.add(:phone_number, 'を入力してください') if address.present? && phone_number.blank?
  end

  def save_with_manager(email, is_president)
    transaction do
      save!
      manager = Manager.new(employee_id: id, email: email, is_president: is_president)
      manager.save!
    end
  end

  def save_with_order_detail(current_company)
    transaction do
      save!
      order_detail = OrderDetail.new(
        order_id: current_company.next_order.id,
        employee_id: id,
        menu_id: current_company.flower_shop.cheapest_menu_of_the_season.id,
        deliver_to: 0,
        discarded_at: nil,
        birthday_message: "#{name}さん、お誕生日おめでとうございます！"
      )
      order_detail.save!
    end
  end

  def update_with_order_detail(employee_params, current_company)
    transaction do
      update!(employee_params)

      my_next_order_detail = OrderDetail.find_by(order_id: current_company.next_order.id, employee_id: id)

      # 誕生日が次回注文の範囲内 かつ 来月のオーダーにまだオーダーがない場合
      if is_birthday_within_next_order_term? && my_next_order_detail.nil?
        order_detail = OrderDetail.new(
          order_id: current_company.next_order.id,
          employee_id: id,
          menu_id: current_company.flower_shop.cheapest_menu_of_the_season.id,
          deliver_to: 0,
          discarded_at: nil,
          birthday_message: "#{name}さん、お誕生日おめでとうございます！"
        )
        order_detail.save!

      # 誕生日が次回注文の範囲内 かつ 来月のオーダーにオーダーがある場合
      elsif !is_birthday_within_next_order_term? && my_next_order_detail.present?
        my_next_order_detail.destroy!
      else
        true
      end
    end
  end

  def destroy_with_manager
    transaction do
      manager.destroy!
      discard!
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

  def age_after_birthday
    age + 1
  end

  # 30歳、40歳、50歳、60歳、70歳...などの節目の年の場合、trueを返す
  def is_milestone_birthday
    age_after_birthday % 10 == 0
  end

  # 勤続年数を返す(joined_atから現在までの年数)
  def working_years
    now = Date.today
    diff_years = now.year - joined_at.year

    is_earlier_todays_date = now.month < joined_at.month || (now.month == joined_at.month && now.day < joined_at.day)

    diff_years -= 1 if is_earlier_todays_date

    diff_years
  end

  def is_birthday_within_next_order_term?
    deadline = Time.new(Time.zone.now.year, Time.zone.now.month, Order.order_date, 9, 0, 0)

    next_month = Time.zone.now.next_month.strftime('%m').to_i
    two_months_later = Time.zone.now.next_month.next_month.strftime('%m').to_i

    is_birthday_next_month = birthday.month == next_month
    is_birthday_two_months_later = birthday.month == two_months_later

    is_current_time_before_deadline = Time.zone.now <= deadline

    # 条件① : 誕生日が翌月 かつ 現在時刻が15日 08:59以内
    return true if is_birthday_next_month && is_current_time_before_deadline
    # 条件② : 誕生日が翌々月 かつ 15日 09:00以降
    return true if is_birthday_two_months_later && !is_current_time_before_deadline

    false
  end
end
