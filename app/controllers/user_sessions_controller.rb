# encoding: utf-8
class UserSessionsController < ApplicationController

  #用户登录
  def new

  end

  def create
    user = C::User.find_by_token('wl2Bofa07OueIiMKHkSU')

    respond_to do |format|
      if params[:user_session][:login] == 'admin'&& params[:user_session][:password] == '12345678'
        session[:user_id] = user.id
        format.html { redirect_to(params[:return_to] || '/a', :notice => '成功登录') }
      else
        flash[:warning] = '登录失败,请重新登录.'
        format.html { render :action => "new", :layout=> true }
      end
    end
  end

  #退出
  def destroy
    reset_session
    flash[:notice] = '退出成功.'
    redirect_to root_url
  end
end
