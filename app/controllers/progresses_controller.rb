class ProgressesController < ApplicationController
  before_action :set_progress, only: [:show, :edit, :update, :destroy]
  helper_method :findByLesson, :findByProgressType_id, :findByCurrentStatusId, :current_curriculum

  # GET /progresses
  # GET /progresses.json
  def index
    @progress_types = ProgressType.all
    @curriculum = Curriculum.find(params[:curriculum_id])
    progress_type_ids = @curriculum.progress_type_ids.split(",").map(&:to_i)
    @progress_type_all = @progress_types.find(progress_type_ids)

    session_create()
  end

  def findByProgressType_id(progress_type_id)
    if current_curriculum.progresses.find_by_progress_type_id(progress_type_id) != nil
      @progress_process = @curriculum.progresses.find_by_progress_type_id(progress_type_id)
    end
  end

  def findByLesson(lesson, progress_type_id)
    current_lesson = current_curriculum.progresses.find_by_lesson_and_progress_type_id(lesson, progress_type_id)

    if current_lesson != nil
      status = ""
      case current_lesson.status
      when 1
        status = "processing"
      when 2
        status = "danger"
      when 3
        status = "success"
      when 4
        status = "none"
      else
        status = "none"
      end
    else
      status = "none"
    end
  end

  def findByCurrentStatusId(lesson, progress_type_id)
    @current_lesson = current_curriculum.progresses.find_by_lesson_and_progress_type_id(lesson, progress_type_id)
  end

  # GET /progresses/1
  # GET /progresses/1.json
  def show
  end

  # GET /progresses/new
  def new
    @progress = Progress.new
  end

  # GET /progresses/1/edit
  def edit
  end

  def multi_edit
    @progresses = Progress.find_by_curriculum_id(current_curriculum)

    @progress_type = ProgressType.new
    @progress_types = ProgressType.all

    progress_type_ids = current_curriculum.progress_type_ids.split(",").map(&:to_i)
    @progress_type_all = @progress_types.find(progress_type_ids)

    @processing = {"진행중" => 1, "지연" => 2, "완료" => 3, "없음" => 4}
  end 

  # 공정률 페이지 업데이트
  def multi_update
    # form 갯수 만큼 for문 돌림
    0.upto(params[:ids].count - 1) do |i|
      # 해당 progress의 id값을 찾아 progress 변경
      progress = Progress.find(params[:ids][i])
      status = params[:progress_ids][i].to_i

      progress.update_attribute(:status, status)

      # 진행상황에 따른 퍼센트 계산 완료 상태일때만 100으로 계산함
      if status == 3
        progress_per = 100
      elsif status == 2
        progress_per = 20
      elsif status == 1
        progress_per = 50
      else
        progress_per = 0
      end
      progress.update_attribute(:process, progress_per)
    end

    flash[:notice] = "진행 상황이 업데이트 되었습니다."
    redirect_to curriculum_progresses_path(current_curriculum.project, current_curriculum)
  end

  def progress_remove
    progress_type_id = params[:progress_type_id]

    # Lecture 의 progress_type_ids 변경
    progress_type_ids = current_curriculum.progress_type_ids.split(",").map(&:to_i)
    progress_type_ids.delete(progress_type_id.to_i)
    progress_type_ids_string = progress_type_ids.join(",")

    current_curriculum.update_attribute(:progress_type_ids, progress_type_ids_string)

    # 해당 progress 데이터 삭제
    @progress = current_curriculum.progresses.where(:progress_type_id => progress_type_id.to_i)

    flash[:notice] = "해당 공정률이 삭제 되었습니다."
    redirect_to curriculum_progress_edit_path(current_curriculum.project, current_curriculum)
  end

  # POST /progresses
  # POST /progresses.json
  def create
    @progress = Progress.new(progress_params)

    respond_to do |format|
      if @progress.save
        format.html { redirect_to @progress, notice: 'Progress was successfully created.' }
        format.json { render action: 'show', status: :created, location: @progress }
      else
        format.html { render action: 'new' }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /progresses/1
  # PATCH/PUT /progresses/1.json
  def update
    respond_to do |format|
      if @progress.update(progress_params)
        format.html { redirect_to @progress, notice: 'Progress was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progresses/1
  # DELETE /progresses/1.json
  def destroy
    @progress.destroy
    respond_to do |format|
      format.html { redirect_to progresses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progress
      @progress = Progress.find(params[:id])
    end

    def current_curriculum
      @current_curriculum = Curriculum.find(params[:curriculum_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def progress_params
      params.require(:progress).permit(:project_id, :curriculum_id, :lesson, :process, :progress_type_id, :status)
    end
end
