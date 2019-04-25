class ArticlesController < ApplicationController
    before_action :authenticate_user, only: [:new, :create]
    before_action :ensure_current_user, only: [:edit, :update, :delete]
    
    def index
        # createやupdateにブラウザバック等で帰ると不具合が起きるため、マイページに戻るようにしています。
        # TODO: 本当は直前のページに戻る方がいい。が、リダイレクトループに入る危険性もある。ちょっと後回し。
        redirect_to(user_page_path(@current_user.username))
    end

    def show
        @article = Article.find(params[:id])
        @comment = @article.comments.build
        @comments = Comment.where(article_id: params[:id])
    end

    def new
        @article = Article.new
    end

    def create
        # 入力が失敗した時のために保持
        @title = params[:article][:title]
        @content = params[:article][:content]

        @article = Article.new(article_params.merge(user_id: @current_user.id))
        if @article.save
            redirect_to(user_page_path(@current_user.username), notice: "記事を作成しました。")
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
            redirect_to(user_page_path(@current_user.username), notice: "編集しました。")
        else
            render("articles/edit") 
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

    def article_params
        params.require(:article).permit(:title, :content, :status)
    end
end
