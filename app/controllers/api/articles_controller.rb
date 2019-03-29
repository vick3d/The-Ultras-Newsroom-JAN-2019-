class Api::ArticlesController < ApplicationController
  def index
    articles = Article.all.approved
    render json: { articles: articles }
  end
end
