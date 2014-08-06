class Admin::UserRoleController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  helper_method :find_curriculums
  helper_method :select_project_id

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)

    @users = User.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def create

  end

  def show
  end

  def edit
    @user = User.find(params[:id])
    session[:role_user] = @user.id

    @user_curriculums = UserCurriculum.new

    @projects = Project.all
    @project_id = params[:project_id].to_i
  end

  def select_project
    @project_id = params[:project_id].to_i

    respond_to do |format|
      format.js {render :layout => false }
    end
  end

  def add_curriculum
    @user_curriculum = UserCurriculum.find_by_user_id_and_curriculum_id(session[:role_user].to_i, params[:curriculum_id])
    
    @saved = false

    if @user_curriculum == nil
      @user_curriculum = UserCurriculum.new
      @user_curriculum.user_id = session[:role_user].to_i
      @user_curriculum.curriculum_id = params[:curriculum_id].to_i

      @user_curriculum.save

      @curriculum = Curriculum.find(params[:curriculum_id])
      @saved = true

      flash[:notice] = "해당 과정이 등록되었습니다."
    end

    respond_to do |format|
      if @saved == true
        format.js {render :layout => false }
      else
        format.js {}
      end
    end
  end

  def remove_curriculum
    @user_curriculum = UserCurriculum.find_by_user_id_and_curriculum_id(session[:role_user].to_i, params[:curriculum_id])

    @curriculum = Curriculum.find(params[:curriculum_id])
    
    @user_curriculum.destroy

    respond_to do |format|
      if @user_curriculum.destroy 
        format.js { render :layout => false }
      end
    end

    flash[:notice] = "해당 과정이 삭제되었습니다."

    # respond_to do |format|
    #   format.html { redirect_to edit_user_role_path(params[:curriculum_id]), notice: '해당 과정이 삭제되었습니다.' }
    # end
  end

  def find_by_user_curriculum(user, curriculum_id)
    @user_curriculum = UserCurriculum.find_by_user_id_and_curriculum_id(user, curriculum_id)
  end

  def find_curriculums(p_id)
    Curriculum.where(:project_id => p_id.to_i)
  end

  def update
    redirect_to user_role_index_path
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:message).permit(:project_id, :user_id, :m_type, :to, :from, :content)
    end
end
