require 'test_helper'

class A::MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
