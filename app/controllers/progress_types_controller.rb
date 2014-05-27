class ProgressTypesController < ApplicationController
  before_action :set_progress_type, only: [:show, :edit, :update, :destroy]

  # GET /progress_types
  # GET /progress_types.json
  def index
    @progress_types = ProgressType.all
  end

  # GET /progress_types/1
  # GET /progress_types/1.json
  def show
  end

  # GET /progress_types/new
  def new
    @progress_type = ProgressType.new
  end

  # GET /progress_types/1/edit
  def edit
  end

  # POST /progress_types
  # POST /progress_types.json
  def create
    @progress_type = ProgressType.new(progress_type_params)

    progress_type_name = ProgressType.find_by_name(@progress_type.name)

    # 기존 이름이 있을시에 해당 ID값을 가져옴
    if progress_type_name != nil
      current_id = progress_type_name.id
    else
      @progress_type.save
      current_id = @progress_type.id
    end    

    # Curriculum 의 progress_type_ids 변경
    progress_type_ids = current_curriculum.progress_type_ids.split(",").map(&:to_i)
    progress_type_ids.push(current_id)
    progress_type_ids_string = progress_type_ids.join(",")
    
    #변경 된 값 update
    current_curriculum.update_attribute(:progress_type_ids, progress_type_ids_string)

    # 전체 차시수
    total_chapter = current_curriculum.total

    # 공정률 데이터 베이스 생성
    1.upto(total_chapter) do |i|
      progress = Progress.new
      progress.lesson = i
      progress.curriculum_id = current_curriculum.id
      progress.progress_type_id = current_id
      progress.process = 0
      progress.status = 4
      progress.save
    end

    respond_to do |format|
      if @progress_type.save
        format.html { redirect_to curriculum_progresses_path(current_curriculum.project, current_curriculum), notice: '항목이 추가되었습니다.' }
        format.json { render action: 'show', status: :created, location: @progress_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @progress_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /progress_types/1
  # PATCH/PUT /progress_types/1.json
  def update
    respond_to do |format|
      if @progress_type.update(progress_type_params)
        format.html { redirect_to curriculum_progresses_path(current_curriculum.project, current_curriculum), notice: 'Progress type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @progress_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progress_types/1
  # DELETE /progress_types/1.json
  def destroy
    @progress_type.destroy
    respond_to do |format|
      format.html { redirect_to progress_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progress_type
      @progress_type = ProgressType.find(params[:id])
    end

    def current_curriculum
      @current_curriculum = Curriculum.find(session[:curriculum_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def progress_type_params
      params.require(:progress_type).permit(:name)
    end
end
