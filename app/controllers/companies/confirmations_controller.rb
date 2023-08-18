# frozen_string_literal: true

class Companies::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new

  # POST /resource/confirmation

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      # TODO: use `error_status` when the default changes to `:unprocessable_entity`.
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

  # The path used after resending confirmation instructions.

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      Order.create(company_id: resource.id, flower_shop_id: resource.flower_shop_id, total_amount: nil, ordered_at: nil)

      signed_in_root_path(resource)
    else
      new_session_path(resource_name)
    end
  end
end
