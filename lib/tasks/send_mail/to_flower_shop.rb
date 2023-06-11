class Tasks::SendMail::ToFlowerShop < Tasks::AbstBatch
  def self.exec
    execute('花屋さんへメールを送信します') do
      Company.all.each do |company|
        company.next_month_order_to_flower_shop
      end
    end
  end
end