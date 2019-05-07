class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :create_comment]

  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user.id, article_id: params[:article_id]))
    if @comment.save
      flash[:notice] = "コメントを投稿しました。"
    else
      flash[:error] = "コメントを入力してください。"
    end
    redirect_back(fallback_location: article_path(params[:article_id]))
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    if @comment.save
      flash[:notice] = "コメントを編集しました。"
    else
      flash[:error] = "コメントを入力してください。"
    end
    redirect_back(fallback_location: article_path(params[:id]))
    puts @comment.errors.full_messages
  end

  def destroy
    comment = Comment.find(params[:id])
    # コメントのdelete権限を確認。外部からdeleteリクエストを投げられた場合の対策。
    unless current_user
      return
    end
    article = Article.find(comment.article_id)
    if @current_user.id == comment.user_id || current_user.id == article.user_id
      comment.destroy
      redirect_back(fallback_location: article_path(article.id), notice: "コメントを削除しました。")
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
