class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  
    def logged_in_user
      unless logged_in? || current_user.admin?
        redirect_to login_path, notice: "ログインをしてください。"
      end
    end
    
end
