# frozen_string_literal: true

class ManagerMailer < ApplicationMailer
  default from: Settings[:SYSTEM_MAIL_ADDRESS]

  def remind_to_president
    @company_name = params[:company_name]
    @company_email = params[:company_email]
    president_email = params[:president_email]
    manager_emails = params[:manager_emails]
    @president_and_manager_emails = []
    @president_and_manager_emails << president_email
    @president_and_manager_emails << manager_emails

    @deadline = 16
    # deadlineの5日前かを判別
    @is_ten_days_before_deadline = Time.zone.now.day == @deadline - 5

    @next_order_link = next_order_url
    @delete_employee_link = root_url

    mail(
      to: @company_email,
      cc: @president_and_manager_emails,
      subject: '【Thanks Gift】翌月の注文に関するリマインド'
    )
  end
end
