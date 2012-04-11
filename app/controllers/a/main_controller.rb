# encoding: utf-8
class A::MainController < A::BaseController
  def index
  end

  private
  # 获取页面导航相关信息的方法，供前置过滤器调用
  def page_nav_relations
    return [{:text=>"管理", :scope => :all},
    ], []
  end
end
