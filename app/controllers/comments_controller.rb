class CommentsController < ApplicationController
    before_action :authenticate_user, only: [:new, :create, :create_comment]
    def create
        comment = Comment.new(content: params[:content], user_id: @current_user.id, article_id: params[:id])
        if comment.save
            redirect_back(fallback_location: article_path(params[:id]))
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        # コメントのdelete権限を確認。外部からdeleteリクエストを投げられた場合の対策。
        unless @current_user
            return
        end
        article = Article.find(comment.article_id)
        if @current_user.id == comment.user_id || @current_user.id == article.user_id
            comment.destroy
            redirect_back(fallback_location: article_path(params[:id]))
        end
    end
end
