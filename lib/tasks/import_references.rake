# encoding: utf-8

desc "import data from the other table which can be connected."
namespace :db do
  #转存应用
  task :import_references => :environment do
    #从其他数据中导入数据
    class Temp < ActiveRecord::Base
      set_table_name 'documents'
    end
    Temp.establish_connection(:adapter => "mysql2", :host => "localhost", :database => "redmine", :username => "root", :password => "root")
#=====================articles===============================
    Temp.find_each(:batch_size => 1000) do |temp|
      Article.create do |t|
        t.user_id = 1, #创建者
        t.category_id = temp.category_id, #分类
        t.title = temp.title, #名称
        t.content = temp.description, #描述
        t.comment_counts = 0, #评论数
        t.view_counts = 0, #浏览数
        t.visible = 1 #是否可见
      end
    end
#====================================================
  end
end