class Admin::ProjectsController < ApplicationController
  before_action :set_project, only: [:remove_project]
  def index
    @projects = Project.order("ID DESC").paginate(:page => params[:page], :per_page => 10)

    @projects = Project.order("ID DESC").search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def remove_project
    @project.boards.each do |board|
      board.delete
    end

    @project.delete
    respond_to do |format|
      format.html { redirect_to projects_index_path, notice: '해당 프로젝트가 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end
end
