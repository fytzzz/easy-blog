# encoding: utf-8
class A::BaseController < ApplicationController
  http_basic_authenticate_with :name => "easy_blog", :password => "12345678"
  layout proc { |controller| controller.request.xhr? ? nil : "layouts/a/application" }
end
