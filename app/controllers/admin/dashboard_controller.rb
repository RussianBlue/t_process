class Admin::DashboardController < ApplicationController
  def index
    @users = User.all
    @projects = Project.all
    @curriculums = Curriculum.all
    @boards = Board.all
    @messages = Message.all
  end
end
