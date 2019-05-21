class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create, destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.article_id = params[:article_id]
    if @comment.save
      redirect_to(article_path(params[:article_id]), notice: (I18n.t 'posted_a_comment'))
    else
      redirect_to(article_path(params[:article_id]), alert: (I18n.t 'Please_input_a_comment'))
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to(article_path(@comment.article_id), notice: (I18n.t 'edited_a_comment'))
    else
      redirect_to(article_path(@comment.article_id), alert: (I18n.t 'Please_input_a_comment'))
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    article = comment.article

    if current_user.id == comment.user_id || current_user.id == article.user_id
      comment.destroy
      redirect_to(article_path(article), alert: (I18n.t 'deleted_a_comment'))
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
