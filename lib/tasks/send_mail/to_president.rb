# frozen_string_literal: true

class Tasks::SendMail::ToPresident < Tasks::AbstBatch
  def self.exec
    execute('社長へ来月の注文に関するリマインドメールを送信します') do
      Manager.presidents.each(&:remind_to_president)
    end
  end
end
