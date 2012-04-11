# encoding: utf-8
class TagsController < ApplicationController

  def index
    @articles = Article.tagged_with(params[:name], :on => :tags, :any => true).page(params[:page])
    render :template => 'articles/index'
  end

end
