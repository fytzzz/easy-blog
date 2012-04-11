# encoding: utf-8
class User < ActiveRecord::Base
  validates_presence_of :login, :message => "登录名不能为空"
  validates_presence_of :email, :message => "email不能为空"
  acts_as_tagger
  has_many :articles #博客
  #可见的文章
  def visible_articles
    self.articles.visible_articles
  end
end
