class Admin::DashboardController < ApplicationController
  def index
  	if current_user.authorize == "super" || current_user.authorize == "admin"
  		@users = User.all
  		@projects = Project.all
  		@curriculums = Curriculum.all
  		@boards = Board.all
  		@messages = Message.all
  	else
  		redirect_to root_path(:subdomain => false)
  	end
  end
end
