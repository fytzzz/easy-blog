# encoding: utf-8
class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  #首页
  def index
    @articles = current_user.visible_articles.page(params[:page]).per(15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find_by_permalink(params[:id])
    @article.increment!(:views_count)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  rescue Exception => ex
    flash[:error] = "文章没找到或无权限浏览.-#{@article.errors.messages}"
    redirect_to root_path
  end
end
