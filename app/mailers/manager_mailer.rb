# frozen_string_literal: true

class ManagerMailer < ApplicationMailer
  # TODO: システムからの送信用アドレスにする or 他の送信用のアドレスを何するか決める
  default from: 'dummy@example.com'

  def remind_to_president
    @president_name = params[:president_name]
    @president_email = params[:president_email]

    # TODO: 仮で値を置いている。後で変更する
    @deadline = 15

    # TODO: 環境に応じてドメインを変更する
    @next_order_link = 'http://localhost:3000/managers'
    @delete_employee_link = 'http://localhost:3000/employees'

    mail(
      to: @president_email,
      subject: '【ONE-STEP-GIFT】翌月の注文に関するリマインド'
    )
  end
end
