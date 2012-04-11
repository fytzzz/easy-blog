# encoding: utf-8
class HomeController < ApplicationController

  #首页
  def index
    @days = 200
    @date_to = Date.today + 1
    @date_from = @date_to - @days
    @activity = Redmine::Activity::Fetcher.new(current_user)
    @activity.scope = :all if @activity.scope.empty?

    events = @activity.events(@date_from, @date_to)
    #==================================
    #@articles = current_user.visible_articles.page(params[:page]).per(15)

    respond_to do |format|
      format.html {
        @events_by_day = events.group_by(&:event_date)
        render :layout => false if request.xhr?
      } # index.html.erb
      format.json { render json: @articles }
    end
  end

end
