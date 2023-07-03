# frozen_string_literal: true

class CompanyMailer < ApplicationMailer
  before_action :set_company_name_and_email
  before_action :set_flower_shop_name_and_email, only: %i[order_to_flower_shop no_order_to_flower_shop]

  SUBJECT_TO_FLOWER_SHOP = '【ONE-STEP-GIFT】来月の注文依頼'

  def order_to_flower_shop
    @next_orders_info = params[:next_orders_info]

    mail(
      to: @flower_shop_email,
      from: @company_email,
      subject: SUBJECT_TO_FLOWER_SHOP
    )
  end

  def no_order_to_flower_shop
    mail(
      to: @flower_shop_email,
      from: @company_email,
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
