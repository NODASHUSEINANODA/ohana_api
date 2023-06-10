class CompanyMailer < ApplicationMailer
  def order_to_flower_shop
    @company_name = params[:company_name]
    @company_email = params[:company_email]
    @flower_shop_name = params[:flower_shop_name]
    @flower_shop_email = params[:flower_shop_email]
    @birthday_members = params[:members]

    mail(
      to: @flower_shop_email,
      from: @company_email,
      subject: "注文依頼",
    )
  end
end
