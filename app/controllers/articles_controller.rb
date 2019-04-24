class ArticlesController < ApplicationController
    before_action :authenticate_user, only: [:new, :create]
    before_action :ensure_current_user, only: [:edit, :update, :delete]
    
    def show
        @article = Article.find_by(id: params[:id])
        @comments = Comment.where(article_id: params[:id])
    end

    def new
    end

    def create
        article = Article.new(title: params[:title], content: params[:content], open_flg: params[:open_flg], user_id: @current_user.id)
        if article.save
            redirect_to("/users/#{@current_user.username}", notice: "記事を作成しました。")
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
            redirect_to("/users/#{@current_user.username}", notice: "編集しました。")
        end
    end

    def delete
        @article = Article.find_by(id: params[:id])
        @article.destroy
        redirect_to("/users/#{@current_user.username}", notice: "削除しました。")
    end

    private

    def ensure_current_user
        @article = Article.find_by(id: params[:id])
        unless @current_user
            redirect_to("/signup", notice: "ログインしていません。")
            return
        end
        if @current_user.id != @article.user_id
            redirect_to("/users/#{@current_user.username}", notice: "権限がありません。")
        end
    end

    def deletable?(comment)
        # あるコメントに対して、削除可能かどうか判定します
        article = Article.find(params[:id])
        return @current_user.id == comment.user_id || @current_user.id == article.user_id
    end

    helper_method :deletable?
end
