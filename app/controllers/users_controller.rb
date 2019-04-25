class UsersController < ApplicationController
    before_action :authenticate_user, only: [:logout]
    before_action :forbid_login_user, only: [:signup, :create, :login, :login_form]

    def signup
        @user = User.new
    end

    def login_forms
    end

    def login
        @user = User.find_by(username: params[:username])
        # 暗号化されたパスワードと検証
        if @user && @user.valid_password?(params[:password])
            session[:user_id] = @user.id
            redirect_to("/users/#{params[:username]}", notice: "ログインしました。")
        else
            flash[:notice] = "ユーザー名またはパスワードが間違っています。"
            render("users/login_form")
        end
      end

    def create
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id
            redirect_to(user_page_path(@user.username), notice: "登録しました。")
        else
            render("users/signup")
        end
    end

    def show
        redirect_to(user_page_path(params[:username]))
    end

    def logout
        session[:user_id] = nil
        redirect_to("/", notice: "ログアウトしました。")
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
