class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  helper_method :show_project
  respond_to :html, :js
  # GET /projects
  # GET /projects.json
  def index
    if current_user.authorize == "super" || current_user.authorize == "admin"
      @projects = Project.paginate(:page => params[:page], :per_page => 10)

      @projects = Project.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
    else
      current_user_project = current_user.curriculums

      if current_user_project != nil
        curriculum_ids = []
        current_user_project.each do |curriculum|
          curriculum_ids.push(curriculum.project)
        end
        @projects = Project.where(:id => curriculum_ids).where.not(:finish => true).paginate(:page => params[:page], :per_page => 10)
        
        @projects = Project.where(:id => curriculum_ids).search(params[:search]).where.not(:finish => true).paginate(:page => params[:page], :per_page => 10)
      end
    end
    
    @project = Project.new
  end

  # GET /projects/1
  # GET /projects/1.json
  def show

  end

  # GET /projects/new
  def new
    
  end

  # GET /projects/1/edit
  def edit
    
  end

  def create_project_id(arg)
    '%06d' % arg
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    # 프로젝트코드 생성
    if Project.all.count < 1
      p_code = create_project_id(1)
    else
      p_code = create_project_id(Project.all.last.id.to_i + 1)
    end
    
    @project.p_code = p_code

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: '프로젝트가 생성되었습니다.' }
        format.json { render action: 'create', status: :created, location: @project }
        format.js   { render action: 'create', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js   { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    current_user_project = current_user.user_curriculums
    
    if params[:project][:finish] == "true"
      @project.update_attribute(:finished_at, Time.now)
    end

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_url, notice: '프로젝트가 수정되었습니다.' }
        format.json { render action: 'update', status: :created, location: @project }
        format.js   { render action: 'update', status: :created, location: @project }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: '프로젝트가 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:years, :title, :p_code, :finish, :finished_at, :width, :height)
    end
end
