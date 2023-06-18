# frozen_string_literal: true

class Companies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    # @flower_shops = FlowerShop.pluck(:name, :id)
    @flower_shops = FlowerShop.all
    super
  end

  # POST /resource

  # GET /resource/edit

  # PUT /resource

  # DELETE /resource

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email flower_shop_id address password])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email flower_shop_id address password])
  end

  # The path used after sign up.
  def after_sign_up_path_for(_resource)
    new_company_session_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(_resource)
    flash[:notice] = '登録が完了しました。メールをご確認ください。'
    companies_sign_up_confirm_path
  end
end
