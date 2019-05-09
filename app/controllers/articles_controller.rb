class ArticlesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update]
    before_action :ensure_current_user, only: [:edit, :update, :delete]

    def index
        @user = User.find_by(username: params[:username])
        @articles = Article.order("id").page(params[:page]).per(3).where(user_id: @user.id)
    end

    def show
        @article = Article.find(params[:id])
        # 非公開設定されているなら、権限確認
        if @article.not_open?
            ensure_current_user
        end
        @comments = Comment.order("id").where(article_id: params[:id])
    end

    def new
        @article = Article.new
    end

    def create
        # 入力が失敗した時のために保持
        @title = params[:article][:title]
        @content = params[:article][:content]

        @article = Article.new(article_params.merge(user_id: current_user.id))
        if @article.save
            redirect_to(user_page_path(current_user.username), notice: "記事を作成しました。")
        else
            render("articles/new")
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        @article.update(article_params)
        if @article.save
            redirect_to(user_page_path(current_user.username), notice: "記事を編集しました。")
        else
            render("articles/edit")
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to(user_page_path(current_user.username), notice: "記事を削除しました。")
    end

    private
    def ensure_current_user
        @article = Article.find(params[:id])
        if current_user.id != @article.user_id
            redirect_to(user_page_path(current_user.username), alert: "権限がありません。")
        end
    end

    def article_params
        params.require(:article).permit(:title, :content, :status)
    end
end
