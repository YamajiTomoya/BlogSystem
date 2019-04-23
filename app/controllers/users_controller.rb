class UsersController < ApplicationController
    before_action :authenticate_user, {only: [:logout]}
    before_action :forbid_login_user, {only: [:signup, :create, :login, :login_form]}

    def signup
        puts "This is signup."
    end

    def login_form
    end

    def login
        puts params[:username], params[:password]
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to("/users/#{params[:username]}")
        else
            render("login_form")
        end
      end

    def create
        puts "This is create"
        puts "username:", params[:username]
        puts "password", params[:password]
        user = User.new(username: params[:username], password: params[:password])
        if user.save
            puts "save successed!"
            session[:user_id] = user.id
            redirect_to("/users/#{user.username}")
        end
        puts user.errors.full_messages
    end

    def show
        @user = User.find_by(username: params[:username])
        @articles = Article.where(user_id: @user.id)
        # 執筆者は全ての記事を見れますが、非ログインユーザーはカレントユーザーのidを持っていないので、このような記述になっています
        if @current_userw
            if @current_user.id == @user
                @author_flg = true
            end
        end
            
    end

    def logout
        session[:user_id] = nil
        redirect_to("/login")
      end
end
