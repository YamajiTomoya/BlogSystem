class UsersController < ApplicationController
    def index
        if current_user
            redirect_to(user_page_path(current_user.username))
        else
            redirect_to(new_user_session_path)
        end
    end

    def show
        redirect_to(user_page_path(params[:username]))
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
