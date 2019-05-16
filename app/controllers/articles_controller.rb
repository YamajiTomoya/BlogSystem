class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :ensure_current_user, only: %i[edit update destroy]

  def index
    @user = User.find_by(username: params[:username])
    @search = @user.articles.ransack(params[:q])
    @articles = @search.result.order(:id).page(params[:page]).per(3)
  end

  def show
    @article = Article.find(params[:id])
    # 非公開設定されているなら、権限確認
    ensure_current_user if @article.not_open?
    @comments = @article.comments.order(:id)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to(user_page_path(current_user.username), notice: (I18n.t 'posted_an_article'))
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    # 入力が失敗した時のために保持
    @title = @article.title
    @content = @article.content
  end

  def update
    @article = Article.find(params[:id])
    # 入力失敗時には、空の部分には元々持っていた値を入れ、編集した部分はそのまま残すようにします
    @title = params[:article][:title].presence || @article.title
    @content = params[:article][:content].presence || @article.content

    @article.update(article_params)
    if @article.save
      redirect_to(user_page_path(current_user.username), notice: (I18n.t 'edited_an_article'))
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to(user_page_path(current_user.username), notice: (I18n.t 'deleted_an_article'))
  end

  private

  def ensure_current_user
    @article = Article.find(params[:id])
    redirect_to(user_page_path(current_user.username), alert: (I18n.t 'You_do_not_have_the_authority')) if current_user.id != @article.user_id
  end

  def article_params
    params.require(:article).permit(:title, :content, :status, :image)
  end
end
