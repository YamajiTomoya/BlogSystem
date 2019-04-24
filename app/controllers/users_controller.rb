class UsersController < ApplicationController
    before_action :authenticate_user, {only: [:logout]}
    before_action :forbid_login_user, {only: [:signup, :create, :login, :login_form]}

    def signup
        @user = User.new
    end

    def login_forms
    end

    def login
        @user = User.find_by(username: params[:username])
        # 暗号化されたパスワードと検証
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:notice] = "ログインしました。"
            redirect_to("/users/#{params[:username]}")
        else
            # TODO: error_massageが表示されてない
            @error_message = "ユーザー名またはパスワードが間違っています。"
            render("users/login_form")
        end
      end

    def create
        if params[:user][:password] == params[:user][:password_confirm]
            user = User.new(username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
            if user.save
                session[:user_id] = user.id
                flash[:notice] = "登録しました。"
                redirect_to("/users/#{user.username}")
            end
        else
            # TODO: error_massageが表示されてない
            @error_message = "パスワードが一致ていません。"
            render("users/signup")
        end
        
    end

    def show
        @user = User.find_by(username: params[:username])
        @articles = Article.where(user_id: @user.id)
        @author_flg = false
        # 執筆者は全ての記事を見れますが、非ログインユーザーはカレントユーザーのidを持っていないので、このような記述になっています
        if @current_user
            if @current_user.id == @user.id
                @author_flg = true
            end
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました。"
        redirect_to("/login")
      end
end
