# encoding: utf-8
class A::ArticlesController < A::BaseController

  def index
    case params[:act]
      when 'new'
        @article = current_user.articles.new(params[:article])
        @article.tag_list = params[:tags]
        respond_to do |format|
          if @article.save
            format.html { redirect_to a_article_path(@article), notice: '创建成功!' }
            format.json { render json: @article, status: :created, location: @article }
          else
            flash[:error] = "创建失败.-#{@article.errors.full_messages}"
            format.html { render action: "new" }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end
      else
        if params[:submit_delall]&&params[:ids]
          Article.find(params[:ids]).each(&:destroy)
          flash[:notice] = "删除成功!"
        end
        @search = Article.search(params[:search])
        @articles = @search.where(:user_id => current_user.id).order("created_at DESC").page(params[:page])
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @articles }
        end
    end
  rescue Exception => ex
    redirect_to(a_articles_path, :notice => '操作有误,请重新操作.')
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(params[:article])
    respond_to do |format|
      if @article.save
        format.html { redirect_to a_article_path(@article), notice: '创建成功!' }
        format.json { render json: @article, status: :created, location: @article }
      else
        flash[:error] = "创建失败.-#{@article.errors.full_messages}"
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  rescue Exception => ex
    redirect_to(a_articles_path, :notice => '操作有误,请重新操作.')
  end

  def show
    @article = current_user.articles.find(params[:id])
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  #更新文章
  def update
    @article = current_user.articles.find(params[:id])
    @article.tag_list = params[:tags]
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to a_article_path(@article), notice: '更新成功!' }
        format.json { head :ok }
      else
        flash[:error] = "更新失败.-#{@article.errors.full_messages}"
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  #修改值
  def change_visible
    raise "Request type error!" unless request.xhr?
    @article = Article.find(params[:id])
    if @article.visible==0
      @article.increment!(:visible)
    elsif @article.visible==1
      @article.decrement!(:visible)
    end
    render :text => 'ok'
  end

  private
  # 获取页面导航相关信息的方法，供前置过滤器调用
  def page_nav_relations
    return [{:text=>"文章", :url=>a_articles_path, :scope => :all},
    ], [{:text=>"新增文章", :url=> new_a_article_path, :scope => :all, :class=>"icon icon-add"}]
  end
end
