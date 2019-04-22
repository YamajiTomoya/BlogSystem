class ArticlesController < ApplicationController
    def new
    end

    def create
        puts params[:title]
        puts params[:open_flg]
        article = Article.new(title: params[:title], content: params[:content], open_flg: params[:open_flg], author: "hoge")
        if article.save
            puts "saved!"
        end
        
    end
end
