# frozen_string_literal: true

class CompanyMailer < ApplicationMailer
  def order_to_flower_shop
    @company_name = params[:company_name]
    @company_email = params[:company_email]
    @flower_shop_name = params[:flower_shop_name]
    @flower_shop_email = params[:flower_shop_email]
    @next_orders_info = params[:next_orders_info]

    mail(
      to: @flower_shop_email,
      from: @company_email,
      subject: '【ONE-STEP-GIFT】来月の注文依頼'
    )
  end
end
