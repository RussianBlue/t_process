class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy]

  # GET /curriculums
  # GET /curriculums.json
  def index
    session_remove()

    if current_user.authorize == "super"
      @curriculums = Curriculum.where(:project_id => current_project).paginate(:page => params[:page], :per_page => 10)
    else
      if current_user.curriculums != nil
        curriculum_ids = []
        current_user.curriculums.each do |curriculum|
          curriculum_ids.push(curriculum)
        end
        @curriculums = Curriculum.where(:id => curriculum_ids).paginate(:page => params[:page], :per_page => 10)
      end
    end
  end

  # GET /curriculums/1
  # GET /curriculums/1.json
  def show
  end

  # GET /curriculums/new
  def new
    @curriculum = Curriculum.new
    @params_action = "create"
  end

  # GET /curriculums/1/edit
  def edit
    @params_action = "update"
  end

  def create_curriculum_id(arg)
    'C' + '%05d' % arg
  end

  # POST /curriculums
  # POST /curriculums.json
  def create
    @params_action = "create"
    @curriculum = Curriculum.new(curriculum_params)

    # 과정 생성시 추가로 등록 할 사항
    @curriculum.project_id = current_project.id
    @curriculum.progress_type_ids = '1,2,3,4,5,6,7,8,9,10'
    @curriculum.save

    # 과정코드 등록
    c_code = create_curriculum_id(Curriculum.all.last.id.to_i)
    @curriculum.c_code = c_code

    total_chapter = params[:curriculum][:total].to_i
    current_id = Curriculum.all.last.id

    if total_chapter > 0
      # 공정률 데이터 베이스 생성
      1.upto(total_chapter) do |i|
        # 기본 10개 Progress_type에서 가져옴
        1.upto(10)  do |k|
          progress = Progress.new
          progress.lesson = i
          progress.curriculum_id = current_id
          progress.progress_type_id = k
          progress.process = 0
          # default = 0
          progress.status = 4
          progress.save
        end
      end

      #최종산출물 페이지 적용
      1.upto(total_chapter) do |i|
        product = Product.new
        product.lesson = i
        product.curriculum_id = current_id
        product.content_use = 0
        product.save
      end
    end   

    respond_to do |format|
      if @curriculum.save
        format.html { redirect_to curriculums_path(current_project), notice: '과정이 등록되었습니다.' }
        format.json { render action: 'show', status: :created, location: @curriculum }
      else
        format.html { render action: 'new' }
        format.json { render json: @curriculum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /curriculums/1
  # PATCH/PUT /curriculums/1.json
  def update
    @params_action = "update"
    # 전체 차시수
    total_chapter = params[:curriculum][:total].to_i
    progress_type_ids = @curriculum.progress_type_ids.split(",").map(&:to_i)

    #기존 입력값이 바뀌었을때 프로그래성 및 공정률 데이터베이스 삭제
    if @curriculum.total < total_chapter
      #생성
      created_ids = @curriculum.total.to_i + 1
      # 공정률 생성
      created_ids.upto(total_chapter) do |i|
        progress_type_ids.each do |k|
          progress = Progress.new
          progress.lesson = i
          progress.curriculum_id = @curriculum.id
          progress.progress_type_id = k
          progress.process = 0
          # default = 0
          progress.status = 4
          progress.save
        end
        #최종산출물 생성
        product = Product.new
        product.lesson = i
        product.curriculum_id = @curriculum.id
        product.content_use = 0
        product.save
      end      
    else
      # 삭제
      remove_ids = @curriculum.total.to_i
      start_chapter = total_chapter + 1

      start_chapter.upto(remove_ids) do |i|
        #공정률삭제
        progress = Progress.where(:curriculum_id => @curriculum.id, :lesson => i.to_i)
        progress.each do |process|
          process.delete
        end

        #최종산출물 삭제
        products = Product.where(:curriculum_id => @curriculum.id, :lesson => i.to_i)

        logger.info { "message = #{products}"}
        products.each do |product|
          product.delete
        end
      end      
    end

    respond_to do |format|
      if @curriculum.update(curriculum_params)
        format.html { redirect_to curriculums_path(current_project), notice: '과정이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @curriculum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /curriculums/1
  # DELETE /curriculums/1.json
  def destroy
    1.upto(@curriculum.total) do |i|
      progress = Progress.where(:curriculum_id => @curriculum.id, :lesson => i.to_i)
      progress.each do |process|
        process.delete
      end

      #최종산출물 삭제
      products = Product.where(:curriculum_id => @curriculum.id, :lesson => i.to_i)
      
      products.each do |product|
        product.delete
      end
    end

    @curriculum.destroy
    respond_to do |format|
      format.html { redirect_to curriculums_path(current_project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    def current_project
      @current_project = Project.find(params[:project_id])
    end

    def current_curriculum
      @current_curriculum = Curriculum.find(params[:curriculum_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curriculum_params
      params.require(:curriculum).permit(:project_id, :total, :title, :c_code, :location, :start, :progress_type_ids, :width, :height)
    end
end
