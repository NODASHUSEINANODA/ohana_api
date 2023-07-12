# frozen_string_literal: true

class Tasks::Sample < Tasks::AbstBatch
  def self.exec
    execute('できるかな??') do
      puts 'putsしてみたよ'
    end
  end
end
