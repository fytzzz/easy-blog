#encoding: utf-8
module ApplicationHelper
  private
  # Renders flash messages
  def render_flash_messages
    s = ''
    flash.each do |k, v|
      s << content_tag('div', v, :class => "flash-tip #{k}")
    end
    s.html_safe
  end


  #@break_crumbs = [[:text=>"控制面版",:url=>"/a"], [:text=>"后台首页", nil]]
  # text: 连接名
  # url: 链接地址
  # scope: 有效action范围
  #>> <a href="/a">控制面版</a> &raquo; 后台首页
  def page_nav_break_crumbs
    crumbs = []
    @break_crumbs.each_with_index do |crumb, i|
      crumbs << (crumb[1] ? link_to(crumb[0], crumb[1]) : crumb[0])
    end
    crumbs.join(' >> ').html_safe
  rescue
    nil
  end

  #[op[:text], op[:url], op[:class]]
  def page_nav_opts
    opts = []
    @opts.each_with_index do |opt, i|
      opts << (opt[1] ? link_to(opt[0], opt[1], :class=>opt[2]) : opt[0])
    end
    opts.join('|').html_safe
  rescue
    nil
  end

  def format_time(time, format=nil)
    return nil unless time
    time = time.to_time if time.is_a?(String)
    if time.is_a?(Time)
      time.strftime(format||Setting[:time_format])
    elsif time.is_a?(Date)
      time.strftime(format||Setting[:date_format])
    else
      nil
    end
  end

  def article_slug(e)
    d = e.created_at
    article_path :year => d.year, :month => d.strftime("%m"), :day => d.strftime("%d"), :id => e.permalink
  end
end
