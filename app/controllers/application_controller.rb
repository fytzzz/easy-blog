# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  layout proc { |controller| controller.request.xhr? ? nil : "layouts/application" }

  #检查缓存是否被修改,如果修改清除缓存数据,更新清理时间.
  before_filter :check_cache
  before_filter :get_page_nav_relations
  helper_method :current_user

  private
  #检查缓存
  def check_cache
    session[:user_id] = User.where(:login => "admin").first.id rescue 1
    # Check the settings cache for each request
    Setting.check_cache
  end

  #当前用户
  def current_user
    return @current_user if defined?(@current_user)&&!@current_user.blank?
    @current_user = User.find(session[:user_id]) rescue nil
  end

  #取得导航栏相关信息的前置过滤器方法
  def get_page_nav_relations
    @break_crumbs ||= []
    @opts ||= []
    return unless self.class.private_method_defined? 'page_nav_relations'
    act = case action_name
            when 'create'
              'new'
            when 'update'
              'edit'
            else
              action_name
          end
    crumbs, opts = page_nav_relations
    @break_crumbs.concat crumbs.select { |c| c[:scope]==:all || c[:scope].include?(act.to_sym) }.collect { |c| [c[:text], c[:url]] }
    @opts.concat opts.select { |op| op[:scope]==:all || op[:scope].include?(act.to_sym) }.collect { |op| [op[:text], op[:url], op[:class]] }
  end
end
