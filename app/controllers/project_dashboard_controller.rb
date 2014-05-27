class ProjectDashboardController < ApplicationController
  def index
  	@project = Project.find(params[:project_id])

  	@notice_boards = @project.boards.order('id DESC').limit(5).find_all_by_category_id(1)
  	@new_boards = @project.boards.order('created_at DESC').limit(5)

		session.delete(:category_id)
  	session.delete(:curriculum_id)
  end
end
