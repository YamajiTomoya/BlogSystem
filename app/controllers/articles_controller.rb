class ArticlesController < ApplicationController
    def new
    end

    def create
        article = Article.new(title: params[:title], content: params[:content], open_flg: params[:open_flg], user_id: @current_user.id)
        if article.save
            puts "saved!"
        end
        puts article.errors.full_messages
    end

    def edit

    end

    def update
    
    end

    def delete
        
    end
end
