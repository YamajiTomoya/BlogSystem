class ArticlesController < ApplicationController
    before_action :authenticate_user, only: [:new, :create]
    before_action :ensure_current_user, only: [:edit, :update, :delete]
    
    def show
        @article = Article.find(params[:id])
        @comments = Comment.where(article_id: params[:id])
    end

    def new
    end

    def create
        article = Article.new(title: params[:title], content: params[:content], status: params[:status], user_id: @current_user.id)
        if article.save
            redirect_to(user_page_path(@current_user.username), notice: "記事を作成しました。")
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        @article.title = params[:article][:title]
        @article.content = params[:article][:content]
        @article.status = params[:article][:status]
        if @article.save
            redirect_to(user_page_path(@current_user.username), notice: "編集しました。")
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to(user_page_path(@current_user.username), notice: "削除しました。")
    end

    private

    def ensure_current_user
        @article = Article.find(params[:id])
        unless @current_user
            redirect_to(login_form_path, notice: "権限がありません。")
            return
        end
        if @current_user.id != @article.user_id
            redirect_to(user_page_path(@current_user.username), notice: "権限がありません。")
        end
    end
end
