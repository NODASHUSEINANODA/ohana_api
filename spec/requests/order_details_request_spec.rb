# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrderDetails', type: :request do
  let(:company) { FactoryBot.create(:company) }
  let(:order) { FactoryBot.create(:order, company: company) }

  before do
    company
    order

    sign_in company
  end

  describe 'PUT #update' do
    let(:order_detail) do
      FactoryBot.create(
        :order_detail,
        order: order,
        deliver_to: 0,
        menu: menu
      )
    end
    let(:menu) { FactoryBot.create(:menu) }
    let(:put_update) do
      put '/next_order',
          params: { 'details' => { '1' => order_detail_params } }
    end
    let(:order_detail_params) { { 'deliver_to' => 'company', 'menu_id' => menu.id } }

    before do
      order_detail
      menu
      order_detail_params
    end

    context '正常な値が入力された場合' do
      context 'メニューを指定した場合' do
        let(:menu2) { FactoryBot.create(:menu) }
        let(:order_detail_params) do
          {
            'deliver_to' => order_detail.deliver_to,
            'menu_id' => menu2.id
          }
        end

        it '更新すること' do
          put_update

          expect(order_detail.reload.menu_id).to eq menu2.id
        end
      end

      context '宛先を指定した場合' do
        let(:order_detail_params) do
          {
            'deliver_to' => 'home',
            'menu_id' => order_detail.menu.id
          }
        end

        it '更新すること' do
          put_update

          expect(order_detail.reload.deliver_to).to eq 'home'
        end
      end

      context '「今回は送らない」を指定した場合' do
        let(:order_detail_params) do
          {
            'deliver_to' => order_detail.deliver_to,
            'menu_id' => order_detail.menu.id,
            'discard' => true
          }
        end

        it '更新すること' do
          put_update

          expect(order_detail.reload.discarded_at).not_to eq nil
        end
      end

      it 'flashメッセージを表示すること' do
        put_update

        expect(flash[:success]).to eq('次回の注文情報を更新しました')
      end

      it 'リダイレクトすること' do
        put_update
        expect(response).to have_http_status :found
      end
    end

    context '無効な値が入力された場合' do
      let(:order_detail_params) { { 'deliver_to' => nil, 'menu_id' => nil } }

      it '更新しないこと' do
        put_update

        expect(order_detail.reload.menu_id).to eq menu.id
      end
    end

    context '次回の注文が存在しない場合' do
      let(:order) { FactoryBot.create(:order) }
      let(:order_detail_params) { {} }

      it 'ルートへリダイレクトされる' do
        put_update

        expect(response).to have_http_status :found
        expect(response).to redirect_to(root_path)
      end

      it 'flashメッセージを表示すること' do
        put_update

        expect(flash[:alert]).to eq('次回の注文データが作成されていません。')
      end
    end
  end
end
