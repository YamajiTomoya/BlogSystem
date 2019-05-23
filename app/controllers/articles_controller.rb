class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :ensure_current_user, only: %i[edit update destroy]

  def index
    @user = User.find_by(username: params[:username])
    @search = @user.articles.ransack(params[:q])
    @articles = @search.result.order(:id).page(params[:page]).per(3)
    # 非公開・投稿予約中の記事を見れるのは投稿者のみ
    @articles = @articles.where(status: :open) if current_user != @user
    @articles = ArticleDecorator.decorate_collection(@articles)

    # ajax通信のみ通る
    return unless request.xhr?

    render 'search_result'
  end

  def show
    @article = Article.find(params[:id])
    # openに設定されていないなら（非公開もしくは予約されているならば）権限確認
    ensure_current_user if @article.not_open?
    @comments = CommentDecorator.decorate_collection(@article.comments.order(:id))
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      message = @article.reserved? ? t('.reserved_an_article') : t('.posted_an_article')
      redirect_to(user_page_path(current_user.username), notice: message)
    else
      render :new
    end
  end

  def edit
    @check = Article.new
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    # 予約投稿をキャンセルしたら予約時間も消す
    @article.post_reservation_at = nil unless @article.reserved?

    # 入力失敗時には、空の部分には元々持っていた値を入れ、編集した部分はそのまま残すようにします
    @check = @article.dup
    @check.attributes = article_params

    if @check.valid?
      @article.update(article_params)
      redirect_to(user_page_path(current_user.username), notice: t('.edited_an_article'))
    else
      @article.attributes.each do |key, _value|
        @article[key] = @check[key] if @check[key].presence
      end
      @article.save
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to(user_page_path(current_user.username), notice: (t '.deleted_an_article'))
  end

  private

  # 現在のユーザーが記事の作成者かを確かめ、そうでなければredirectします
  def ensure_current_user
    @article = Article.find(params[:id])
    unless @article.write_by?(current_user)
      redirect_to(user_page_path(current_user.username), alert: (I18n.t 'You_do_not_have_the_authority'))
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :status, :image, :post_reservation_at)
  end
end
