# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let(:company) { FactoryBot.create(:company) }

  before do
    sign_in company
  end

  describe 'GET index' do
    let(:employee) { FactoryBot.create(:employee) }
    let(:get_index) { get '/', params: params }
    let(:params) { {} }

    it '正常なレスポンスを返すこと' do
      get_index
      expect(response).to have_http_status :ok
    end

    it '社員が表示されていること' do
      get_index
      expect(response.body).to include(employee.name)
    end

    context '検索機能が機能していること' do
      let(:employee1) { FactoryBot.create(:employee, name: 'test1', company: company) }
      let(:employee2) { FactoryBot.create(:employee, name: 'test2', company: company) }
      let(:params) { { name: employee1.name } }

      it 'nameカラムで検索' do
        get_index

        expect(response.body).to include(employee1.name)
        expect(response.body).not_to include(employee2.name)
      end
    end
  end

  describe 'POST create' do
    let(:post_create) { post '/employees', params: { employee: employee_params } }

    context '社員の作成' do
      context '正しい入力値' do
        let(:employee_params) { FactoryBot.attributes_for(:employee) }
        it '社員の作成が成功すること' do
          expect { post_create }.to change { company.employees.count }.by(1)
        end
      end

      context '不正な入力値' do
        let(:employee_params) { FactoryBot.attributes_for(:employee, :invalid) }
        it '社員の作成が失敗すること' do
          expect { post_create }.to change { company.employees.count }.by(0)
        end
      end
    end

    context '管理者の作成' do
      let(:employee_params) {
        FactoryBot.attributes_for(
          :employee,
          is_president: true,
          admin_mail_address: 'manager@example.com'
        )
      }

      context '正しい入力値' do
        it '管理者の作成が成功すること' do
          expect { post_create }.to change { company.managers.count }.by(1)
        end
      end

      context '不正な入力値' do
        it '管理者の作成が失敗すること' do
          employee_params[:admin_mail_address] = ''
          expect { post_create }.to change { company.managers.count }.by(0)
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:employee) { FactoryBot.create(:employee) }
    let(:put_update) do
      put "/employees/#{employee.id}", params: {
        employee: employee.attributes.merge({ name: name })
      }
    end

    context '正常な値が入力された場合' do
      let(:name) { 'new value' }

      it '更新すること' do
        put_update
        expect(employee.reload.name).to eq 'new value'
      end

      it 'リダイレクトすること' do
        put_update
        expect(response).to have_http_status :found
      end
    end

    context '無効な値が入力された場合' do
      let(:employee_params) { { name: '' } }

      it '更新しないこと' do
        put_update
        expect(employee.reload.name).to eq 'before change'
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destory) { delete "/employees/#{employee.id}", params: {} }

    context '社員のみ' do
      let(:employee) { FactoryBot.create(:employee) }

      it '論理削除されること' do
        delete_destory

        expect(employee.discard).to be_truthy
      end
    end

    context '管理者' do
      let(:employee) { FactoryBot.create(:employee, :with_manager) }

      it '社員データが論理削除されること' do
        delete_destory
        expect(employee.discard).to be_truthy
      end

      it '管理者データが削除されること' do
        delete_destory
        expect(Manager.count).to eq(0)
      end
    end
  end
end
