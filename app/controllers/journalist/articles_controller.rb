class Journalist::ArticlesController < ApplicationController
    before_action :check_journalist
    before_action :authenticate_user!
    before_action :check_author, only: [:edit, :destroy, :update]

    def show
        @article = Article.find(params[:id])
    end
    
    def new   
    end

    def create
        article = Article.new(article_params)
        article.user = current_user
        if article.save
            redirect_to new_journalist_article_path, notice: 'Article was successfully created.'
        else
            redirect_to new_journalist_article_path, alert: 'You have to fill out all the fields'
        end
    end

    def update
        if @article.update(article_params)
            @article.approved = false
            @article.save
            redirect_to journalist_article_path, notice: 'Article was successfully updated.'
        else
            redirect_to @article, notice: 'Article was not updated.'
        end
    end

    def destroy
        if params[:deleteimage] == "true"
            @article.image.destroy
            redirect_to articles_path, notice: 'Image was successfully deleted.'
        else
            if @article.destroy
                redirect_to articles_path, notice: 'Article was successfully deleted.'
            else
                redirect_to articles_path, notice: 'Article was not successfully deleted.'
            end
        end
    end

    private

    def check_journalist
        if user_signed_in? && current_user.journalist?
            true
        else
            redirect_to root_path, notice: 'Permission denied.'
        end
    end

    def check_author
        @article = Article.find(params[:id])
        if @article.user == current_user
            true
        else 
            redirect_to articles_path, notice: "You can only edit your own articles."
        end
    end

    def article_params
        params.require(:article).permit(:title, :content, :lead, :image)
    end 
end