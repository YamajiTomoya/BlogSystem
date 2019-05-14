class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user.id, article_id: params[:article_id]))
    if @comment.save
      redirect_to(article_path(params[:article_id]), notice: 'コメントを投稿しました。')
    else
      redirect_to(article_path(params[:article_id]), alert: 'コメント入力してください。')
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    if @comment.save
      redirect_to(article_path(@comment.article_id), notice: 'コメントを編集しました。')
    else
      redirect_to(article_path(@comment.article_id), alert: 'コメント入力してください。')
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    article = comment.article
    # コメントのdelete権限を確認。外部からdeleteリクエストを投げられた場合の対策。
    return unless current_user

    if current_user.id == comment.user_id || current_user.id == article.user_id
      comment.destroy
      redirect_back(fallback_location: article_path(article.id), alert: 'コメントを削除しました。')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
