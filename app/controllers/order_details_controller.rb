# frozen_string_literal: true

class OrderDetailsController < ApplicationController
  before_action :authenticate_company!
  before_action :set_next_order_details, only: %i[edit update]

  def edit
    @menus = Menu.season_menu
    @deliver_to = OrderDetail.deliver_tos_i18n.invert
  end

  def update
    @next_order_details.each_with_index do |detail, i|
      # TODO: 強引に値を取得しているので、もっとスマートな方法があれば修正する
      id = params[:details].to_unsafe_h.to_a[i].first
      param = params[:details][id]
      detail.update(
        deliver_to: param[:deliver_to],
        menu_id: param[:menu_id].to_i,
        discarded_at: param[:discard].present? ? Time.zone.now : nil,
        birthday_message: param[:birthday_message]
      )
    end

    flash[:success] = '次回の注文情報を更新しました'
    redirect_to next_order_path
  end

  private

  def set_next_order_details
    next_order = current_company.orders.where(ordered_at: nil).order(created_at: :desc).first

    return redirect_to root_path, alert: '次回の注文データが作成されていません。' unless next_order.present?

    @next_order_details = next_order.order_details
  end
end
