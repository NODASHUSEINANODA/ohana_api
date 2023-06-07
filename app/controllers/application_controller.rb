class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers

    protected

    def after_sign_out_path_for(resource_or_scope)
        new_company_session_path
    end
end
