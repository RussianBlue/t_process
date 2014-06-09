class Admin::UserRoleController < ApplicationController
  helper_method :find_curriculums
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
    @user_projects = UserProject.new

    @projects = Project.all
  end

  def find_project(arg)
    
  end

  def find_curriculums(arg)
    Curriculum.find_all_by_project_id(arg)
    #Curriculum.all
  end

  def update
  end

  def destroy
  end
end
