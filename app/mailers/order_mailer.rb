class OrderMailer < ApplicationMailer
  before_action :set_president_name_and_email

  default from: Settings[:SYSTEM_MAIL_ADDRESS]

  def shipping_confirmation_to_president
    @next_orders_info = params[:next_orders_info]

    mail(
      to: @president_email,
      subject: '【ONE-STEP-GIFT】翌月の注文に関するリマインド'
    )
  end

  def no_shipping_confirmation_to_president
    mail(
      to: @president_email,
      subject: '【ONE-STEP-GIFT】翌月の注文に関するリマインド'
    )
  end

  def set_president_name_and_email
    @president_name = params[:president_name]
    @president_email = params[:president_email]
  end
end
