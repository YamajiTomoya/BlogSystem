class ArticlesController < ApplicationController
    before_action :ensure_current_user, {only: [:update, :delete]}
    
    def new
    end

    def create
        article = Article.new(title: params[:title], content: params[:content], open_flg: params[:open_flg], user_id: @current_user.id)
        if article.save
            puts "saved!"
        end
        puts article.errors.full_messages
    end

    def edit
        @article = Article.find_by(id: params[:id])
    end

    def update
        @article = Article.find_by(id: params[:id])
        @article.title = params[:article][:title]
        @article.content = params[:article][:content]
        @article.open_flg = params[:article][:open_flg]
        if @article.save
            puts "updated!"
            redirect_to("/users/#{@current_user.username}")
        end
        puts @article.errors.full_messages
    end

    def delete
        @article = Article.find_by(id: params[:id])
        @article.destroy
        puts "deleted!"
        redirect_to("/users/#{@current_user.username}")
    end

    def ensure_current_user
        @article = Article.find_by(id: params[:id])
        puts @article.title
        puts @current_user.id
        if @current_user.id != @article.user_id
            user = User.find_by(id: @article.user_id)
            redirect_to("/users/#{user.username}")
        end
    end
end
