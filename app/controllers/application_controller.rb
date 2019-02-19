class ApplicationController < ActionController::Base

    def current_user
        if session[:user_id].present?
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    helper_method(:current_user)

    def user_signed_in?
        current_user.present?
    end

    helper_method(:user_signed_in?)

    def user_is_coach?
        current_user.present? && (current_user.role == "Coach" || current_user.admin?)
    end

    helper_method(:user_is_coach?)
    
    def user_is_client?
        current_user.present? && current_user.role == "Client"
    end

    helper_method(:user_is_client?)
    
    def user_is_admin?
        current_user.admin?
    end

    helper_method(:user_is_admin?)

    def authenticate_user!
        unless user_signed_in?
            flash[:danger] = "You must sign in or sign up first"
            redirect_to new_session_path
        end
    end
end
