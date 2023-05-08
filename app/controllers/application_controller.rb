class ApplicationController < ActionController::Base
    private
    
    def current_user
        @current_user ||= Company.find_by(id: session[:user_id])
    end

    helper_method :current_user

    protected

    def after_sign_out_path_for(resource_or_scope)
        new_company_session_path
    end
end
