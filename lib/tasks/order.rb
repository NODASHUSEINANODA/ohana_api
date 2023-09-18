# frozen_string_literal: true

class Tasks::Order < Tasks::AbstBatch
  def self.exec
    execute('注文を開始します') do
      # NOTE: 注文後は注文情報が更新され、company.next_orderの内容が変更されるので、運営会社へは先にメールを送信する
      Order.amount_of_sales_to_operating_company

      Company.all.each do |company|
        # NOTE: できればeach内の処理を`app/use_cases/company/send_mail_to_flower_shop.rb`を作成し、そこで行いたい
        formatted_next_orders = company.next_order_details.map(&:prepare_for_company_mailer)

        if formatted_next_orders.present?
          company.order_to_flower_shop(formatted_next_orders)
          company.next_order.shipping_confirmation_to_president(formatted_next_orders)
        else
          company.no_order_to_flower_shop
          company.next_order.no_shipping_confirmation_to_president
        end

        total_amount = company.next_order.calc_amount
        company.next_order.update(total_amount: total_amount, ordered_at: Time.zone.now)
        company.setup_next_order
      end
    end
  end
end
