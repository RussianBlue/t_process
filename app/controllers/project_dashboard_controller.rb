class ProjectDashboardController < ApplicationController
	helper_method :current_curriculum_title

  def index
  	@project = Project.find(params[:project_id])

  	@notice_boards = @project.boards.order('id DESC').limit(5).find_all_by_category_id(1)
  	@new_boards = @project.boards.order('created_at DESC').limit(5)

		session.delete(:category_id)
  	session.delete(:curriculum_id)
  end

  def current_curriculum_title(arg)
  	return Curriculum.find(arg).title
  end
end
