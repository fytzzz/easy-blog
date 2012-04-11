# encoding: utf-8
require "active_record"
require 'active_record/fixtures'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#初始化
%w(users).each do |tablename|
  Fixtures.create_fixtures("#{Rails.root}/db/datas", tablename)
end