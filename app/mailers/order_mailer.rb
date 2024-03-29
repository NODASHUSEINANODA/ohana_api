# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  before_action :set_president_name_and_email

  default from: Settings[:SYSTEM_MAIL_ADDRESS]

  SUBJECT = '【Thanks Gift】注文完了のお知らせ'

  def shipping_confirmation_to_president
    @next_orders_info = params[:next_orders_info]
    @total_amount = params[:total_amount]

    mail(
      to: @company_email,
      cc: @president_and_manager_emails,
      subject: SUBJECT
    )
  end

  def no_shipping_confirmation_to_president
    mail(
      to: @company_email,
      cc: @president_and_manager_emails,
      subject: SUBJECT
    )
  end

  def amount_of_sales_to_operating_company
    @operating_company_email = Settings[:OPERATING_COMPANY_EMAIL]
    @operating_company_name = Settings[:OPERATING_COMPANY_NAME]
    @operating_member_email = Settings[:OPERATING_MEMBER_EMAIL]
    @orders_info = params[:orders_info]
    @total_amount = params[:total_amount]

    mail(
      to: @operating_company_email,
      cc: @operating_member_email,
      subject: '【Thanks Gift】今月の売上金額のお知らせ'
    )
  end

  def set_president_name_and_email
    @company_name = params[:company_name]
    @company_email = params[:company_email]
    @president_and_manager_emails = []
    @president_and_manager_emails << params[:president_email]
    @president_and_manager_emails << params[:manager_emails]
  end
end
