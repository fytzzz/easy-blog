# encoding: utf-8
class Article < ActiveRecord::Base
  validates_presence_of :title, :message => "文章标题不能为空"
  validates_presence_of :content, :message => "文章内容不能为空"
  validates_presence_of :permalink, :message => "文章链接不能为空"
  validates_presence_of :user_id, :message => "创建者不能为空"
  validates_uniqueness_of :permalink, :message => "文章链接标识不能为空"
  #可见的文章
  scope :visible_articles, where("articles.visible = '1'").order("created_at DESC")

  acts_as_taggable
  belongs_to :user #创建者
  acts_as_event :title => Proc.new { |o| "#{o.title}" },
                :url => Proc.new { |o| {:controller => "articles", :action=>"show",
                                        :year => o.created_at.year, :month => o.created_at.strftime("%m"), :day => o.created_at.strftime("%d"), :id => o.permalink}
                },
                :description => Proc.new { |o| "#{o.content}" },
                :author => Proc.new { |o| "#{o.user.name}" }
  acts_as_activity_provider :find_options => {:include => :user}
  #分类
  def category_txt
    Setting[:category_types][category_id] rescue nil
  end

  #分类
  def visible_txt
    Setting[:visible_types][visible] rescue nil
  end

  #分类
  def self.selected_categories
    {'' => "==选择分类=="}.merge(Setting[:category_types]).invert
  end
end
