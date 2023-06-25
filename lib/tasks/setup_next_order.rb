# frozen_string_literal: true

class Tasks::SetupNextOrder < Tasks::AbstBatch
  def self.exec
    execute('翌月の注文データを生成します') do
      Company.all.each(&:setup_next_order)
    end
  end
end
