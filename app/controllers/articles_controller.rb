class ArticlesController < ApplicationController
    before_action :authenticate_user, {only: [:new, :create, :create_comment]}
    before_action :ensure_current_user, {only: [:edit, :update, :delete]}
    
    def show
        @article = Article.find_by(id: params[:id])
        @comments = Comment.where(article_id: params[:id])
        @deletable_flags = []
        @comments.each do |comment|
            if @current_user
                @deletable_flags.push(@current_user.id == comment.user_id || @current_user.id == @article.user_id)
            end
            
        end
    end

    def new
    end

    def create
        article = Article.new(title: params[:title], content: params[:content], open_flg: params[:open_flg], user_id: @current_user.id)
        if article.save
            redirect_to("/users/#{@current_user.username}")
        end
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

    def create_comment
        comment = Comment.new(content: params[:content], user_id: @current_user.id, article_id: params[:id])
        if comment.save
            puts "commented!"
            redirect_back(fallback_location: "/articles/#{params[:id]}")
        end
    end

    def delete_comment
        comment = Comment.find_by(id: params[:id])
        comment.destroy
        redirect_back(fallback_location: "/articles/#{params[:id]}")
    end

    def ensure_current_user
        @article = Article.find_by(id: params[:id])
        puts @article.title
        puts @current_user.id
        # 非ログインユーザーはカレントユーザーのidを持っていないので、このような記述になっています
        if @current_user
            if @current_user.id != @article.user_id
                user = User.find_by(id: @article.user_id)
                redirect_to("/users/#{user.username}")
            end
        else
            redirect_to("/signup")
        end   
    end
end
