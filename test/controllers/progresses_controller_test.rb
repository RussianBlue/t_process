require 'test_helper'

class ProgressesControllerTest < ActionController::TestCase
  setup do
    @progress = progresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:progresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create progress" do
    assert_difference('Progress.count') do
      post :create, progress: { curriculum_id: @progress.curriculum_id, lesson: @progress.lesson, process: @progress.process, progress_type_id: @progress.progress_type_id, project_id: @progress.project_id, status: @progress.status }
    end

    assert_redirected_to progress_path(assigns(:progress))
  end

  test "should show progress" do
    get :show, id: @progress
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @progress
    assert_response :success
  end

  test "should update progress" do
    patch :update, id: @progress, progress: { curriculum_id: @progress.curriculum_id, lesson: @progress.lesson, process: @progress.process, progress_type_id: @progress.progress_type_id, project_id: @progress.project_id, status: @progress.status }
    assert_redirected_to progress_path(assigns(:progress))
  end

  test "should destroy progress" do
    assert_difference('Progress.count', -1) do
      delete :destroy, id: @progress
    end

    assert_redirected_to progresses_path
  end
end
