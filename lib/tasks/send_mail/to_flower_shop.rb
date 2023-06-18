# frozen_string_literal: true

class Tasks::SendMail::ToFlowerShop < Tasks::AbstBatch
  def self.exec
    execute('花屋さんへメールを送信します') do
      Company.all.each(&:next_month_order_to_flower_shop)
    end
  end
end
