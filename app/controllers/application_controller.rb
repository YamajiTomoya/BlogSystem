class ApplicationController < ActionController::Base
    before_action :set_current_user
    private

    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end
    
    def forbid_login_user
      if @current_user
        redirect_to(user_page_path(@current_user.username), notice: "すでにログインしています")
      end
    end
end
