class Admin::UserApprovalController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  	@users = User.paginate(:page => params[:page], :per_page => 10)

    @users = User.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
  end

  def edit
    
  end

  def create
  end

  def update
  	@user = User.find(params[:id])

  	@user.approval = params[:approval]
  	@user.authorize = params[:authorize]
    #logger.info { "c = #{current_user.id.to_s}" }
    #@user.approval_user = current_user.id.to_s

  	respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_approval_index_path, notice: '사용자 정보가 수정되었습니다.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destory
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:approval, :authorize)
    end
end
