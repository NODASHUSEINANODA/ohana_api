class OrderMailer < ApplicationMailer
  before_action :set_president_name_and_email

  default from: Settings[:SYSTEM_MAIL_ADDRESS]

  SUBJECT = '【ONE-STEP-GIFT】注文完了のお知らせ'

  def shipping_confirmation_to_president
    @next_orders_info = params[:next_orders_info]

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

  def set_president_name_and_email
    @president_name = params[:president_name]
    @president_email = params[:president_email]
  end
end
