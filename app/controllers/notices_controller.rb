require 'uri'

class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]
  helper_method :find_original
  
  def download
    @download_file = Board.find(params[:id])
    send_file @download_file.data.path,
              :filename => enc_uri = URI.escape(@download_file.data_file_name),
              :type => @download_file.data_content_type,
              :disposition => 'attachment'
  end

  def index
    @project = Project.find(params[:project_id])

    session_create()

    @current_category = BoardCategory.find(session[:category_id].to_i)

    if session[:curriculum_id] != nil
      #@boards = @project.boards.order('id DESC').find_all_by_category_id_and_curriculum_id(@current_category, session[:curriculum_id].to_i).paginate(:page => params[:page], :per_page => 10)
      @boards = @project.boards.order('group_no DESC').order('seq_no ASC').find_all_by_category_id_and_curriculum_id(@current_category, session[:curriculum_id].to_i).paginate(:page => params[:page], :per_page => 10)
    else
      #@boards = @project.boards.order('id DESC').find_all_by_category_id(@current_category).paginate(:page => params[:page], :per_page => 10)
      @boards = @project.boards.order('group_no DESC').order('seq_no ASC').find_all_by_category_id(@current_category).paginate(:page => params[:page], :per_page => 10)
    end


    #if params[:search] != nil
      #logger.info { "params ======================== #{params[:search]}" }
      #@boards_temp = @project.boards.where(:category_id => @current_category, :curriculum_id => session[:curriculum_id].to_i)
      #@boards = @boards_temp.searchBoard(params[:search]).paginate(:page => params[:page], :per_page => 10)
    #end
  end

  def show
    session_create()

    # 조회 수 업데이트
    @board = Board.find(params[:id])
    @board.update_attribute(:count_at, @board.count_at + 1)
  end

  def new
    @board = Board.new
    @params_action = "create"

    @original_board = params[:board_id]
  end

  def edit
    @board = Board.find(params[:id])
    @params_action = "update"
  end

  def create
    @project = Project.find(params[:project_id])
    @board = Board.new(notice_params)
    @params_action = "create"

    @board.project_id = current_project.id
    @board.category_id = session[:category_id].to_i;

    if session[:category_id].to_i >= 3 && session[:category_id].to_i <= 5
      @board.curriculum_id = current_curriculum.id
    end

    if params[:board_id] != nil 
      session[:board_id] = params[:board_id]
    end

    if session[:board_id] != nil 
      # 답변글에 대한 원글
      original_board = Board.find(session[:board_id].to_i)

      @board.group_no = original_board.group_no
      @board.level = original_board.level.to_i + 1
      @board.seq_no = original_board.seq_no.to_i + 1

      update_board = @project.boards.where(:group_no => original_board.group_no)

      update_board.each do |board_seq|
        if board_seq.seq_no > 1
          board_seq.update_attribute(:seq_no, board_seq.seq_no+1)
        end
      end
    else
      if Board.all.count < 1
        @board.group_no = 1
      else
        @board.group_no = Board.all.last.id.to_i + 1
      end
      @board.level = 1
      @board.seq_no = 1
    end

    @board.user_id = current_user.id    

    respond_to do |format|
      if @board.save
        session.delete(:board_id)
        format.html { redirect_to notice_path(current_project, @board), notice: '글이 등록되었습니다.' }
        format.json { render action: 'create', status: :created, location: @board }
      else
        format.html { render action: 'new' }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @params_action = "update"
    @board = Board.find(params[:id])

    respond_to do |format|
      if @board.update(notice_params)
        format.html { redirect_to notice_path(current_project, @board), notice: '글이 수정되었습니다.' }
        format.json { render action: 'update', status: :created, location: @board }
        format.js   { render action: 'update', status: :created, location: @board }
      else
        format.html { render action: 'edit' }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to notices_path(current_project), notice: '글이 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end

  def find_original(arg)
    board = Board.find(arg) if Board.exists?(arg)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @board = Board.find(params[:id])
    end

    def current_project
      @current_project = Project.find(params[:project_id])
    end

    def current_curriculum
      @current_curriculum = Curriculum.find(session[:curriculum_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notice_params
      params.require(:board).permit(:project_id, :category_id, :title, :pre_title, :user_id, :count_at, :content, :data)
    end
end
