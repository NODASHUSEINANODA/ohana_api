class Tasks::SendMail::ToFlowerShop < Tasks::AbstBatch
  def self.exec
    execute('花屋さんへメールを送信します') do
      # TODO: ここにメールを送信する処理を書く
      puts 'hogehoge'
    end
  end
end