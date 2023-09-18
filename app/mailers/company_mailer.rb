# frozen_string_literal: true

class CompanyMailer < ApplicationMailer
  default from: Settings[:SYSTEM_MAIL_ADDRESS]

  before_action :set_company_name_and_email, only: %i[order_to_flower_shop no_order_to_flower_shop]
  before_action :set_flower_shop_name_and_email, only: %i[order_to_flower_shop no_order_to_flower_shop]

  SUBJECT_TO_FLOWER_SHOP = '【Thanks Gift】来月の注文依頼'

  def order_to_flower_shop
    @next_orders_info = params[:next_orders_info]
    @total_amount = params[:total_amount]

    mail(
      to: @flower_shop_email,
      subject: SUBJECT_TO_FLOWER_SHOP
    )
  end

  def no_order_to_flower_shop
    mail(
      to: @flower_shop_email,
      subject: SUBJECT_TO_FLOWER_SHOP
    )
  end

  private

  def set_company_name_and_email
    @company_name = params[:company_name]
    @company_email = params[:company_email]
  end

  def set_flower_shop_name_and_email
    @flower_shop_name = params[:flower_shop_name]
    @flower_shop_email = params[:flower_shop_email]
  end
end
