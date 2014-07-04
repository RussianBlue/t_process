require 'test_helper'

class Admin::ProjectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get destory" do
    get :destory
    assert_response :success
  end

end
