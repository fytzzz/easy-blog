# encoding: utf-8
class A::BaseController < ApplicationController
  http_basic_authenticate_with :name => "gitrails", :password => "fyt8831252"
  layout proc { |controller| controller.request.xhr? ? nil : "layouts/a/application" }
end
