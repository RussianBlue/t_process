require 'test_helper'

class ProgressTypesControllerTest < ActionController::TestCase
  setup do
    @progress_type = progress_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:progress_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create progress_type" do
    assert_difference('ProgressType.count') do
      post :create, progress_type: { name: @progress_type.name }
    end

    assert_redirected_to progress_type_path(assigns(:progress_type))
  end

  test "should show progress_type" do
    get :show, id: @progress_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @progress_type
    assert_response :success
  end

  test "should update progress_type" do
    patch :update, id: @progress_type, progress_type: { name: @progress_type.name }
    assert_redirected_to progress_type_path(assigns(:progress_type))
  end

  test "should destroy progress_type" do
    assert_difference('ProgressType.count', -1) do
      delete :destroy, id: @progress_type
    end

    assert_redirected_to progress_types_path
  end
end
