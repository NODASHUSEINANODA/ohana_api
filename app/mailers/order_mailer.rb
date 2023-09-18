# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  before_action :set_president_name_and_email

  default from: Settings[:SYSTEM_MAIL_ADDRESS]

  SUBJECT = '【ONE-STEP-GIFT】注文完了のお知らせ'

  def shipping_confirmation_to_president
    @next_orders_info = params[:next_orders_info]
    @total_amount = params[:total_amount]

    mail(
      to: @president_email,
      subject: SUBJECT
    )
  end

  def no_shipping_confirmation_to_president
    mail(
      to: @president_email,
      subject: SUBJECT
    )
  end

  def amount_of_sales_to_operating_company
    @operating_company_email = 'info@fpec.jp'
    @operating_company_name = '株式会社FPEC'
    @orders_info = params[:orders_info]
    @total_amount = params[:total_amount]

    mail(
      to: @operating_company_email,
      subject: '【Thanks Gift】今月の売上金額のお知らせ'
    )
  end

  def set_president_name_and_email
    @president_name = params[:president_name]
    @president_email = params[:president_email]
  end
end
