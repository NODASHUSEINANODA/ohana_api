# frozen_string_literal: true

class Tasks::SendMail::ToFlowerShop < Tasks::AbstBatch
  def self.exec
    execute('花屋さんへメールを送信します') do
      Company.all.each do |company|
        # TODO: each内の処理を`app/use_cases/company/send_mail_to_flower_shop.rb`で行う
        formatted_next_orders = company.next_order_details.map(&:prepare_for_company_mailer)

        if formatted_next_orders.present?
          company.order_to_flower_shop(formatted_next_orders)
        else
          company.no_order_to_flower_shop
        end

        total_amount = company.next_order.calc_amount
        company.next_order.update(total_amount: total_amount, ordered_at: Time.zone.now)
        company.setup_next_order
      end
    end
  end
end
