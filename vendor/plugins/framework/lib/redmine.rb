# coding: utf-8
# Framework
# Step 1 ----require file-------------------------------------------------------
#[
#    :utils, #全局的工具类
#].each do |directory|
#  Dir["#{File.dirname __FILE__}/#{directory.to_s}/*.rb"].sort.each { |file| require file }
#end
require 'redmine/activity'

Redmine::Activity.map do |activity|
  activity.register :articles, :class_name => "Article"
end