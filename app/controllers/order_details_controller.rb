# frozen_string_literal: true

class OrderDetailsController < ApplicationController
  before_action :authenticate_company!
  before_action :set_latest_order_details, only: %i[edit update]

  def edit
    @menus = current_company.flower_shop.menus
    @deliver_to = OrderDetail.deliver_tos_i18n.invert

    return if @latest_order_details.present?

    redirect_to root_path, alert: '次回の注文データが作成されていません。'
  end

  def update
    @latest_order_details.each_with_index do |detail, i|
      param = params[:details][(i + 1).to_s]
      puts 'param'
      puts param
      detail.update(
        deliver_to: param[:deliver_to],
        menu_id: param[:menu_id].to_i,
        discarded_at: param[:discard].present? ? Time.zone.now : nil
      )
    end

    flash[:success] = '次回の注文情報を更新しました'
    redirect_to next_order_path
  end

  private

  def set_latest_order_details
    # 以下のordersの条件にordereda_atが空であることを追加する
    @latest_order_details = current_company.orders.order(created_at: :desc).first.order_details
  end
end
