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
            redirect_to("/users/#{user.username}")
        end
    end

    def show
    end

    def logout
        session[:user_id] = nil
        redirect_to("/login")
      end
end
