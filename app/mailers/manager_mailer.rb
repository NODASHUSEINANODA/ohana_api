# frozen_string_literal: true

class ManagerMailer < ApplicationMailer
  default from: Settings[:SYSTEM_MAIL_ADDRESS]

  def remind_to_president
    @president_name = params[:president_name]
    @president_email = params[:president_email]

    @deadline = 15

    @next_order_link = next_order_url
    @delete_employee_link = root_url

    mail(
      to: @president_email,
      subject: '【ONE-STEP-GIFT】翌月の注文に関するリマインド'
    )
  end
end
