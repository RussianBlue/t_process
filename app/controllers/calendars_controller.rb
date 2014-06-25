class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = current_project.calendars
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
    @params_action = "create"
  end

  # GET /calendars/1/edit
  def edit
    @params_action = "update"
    @calendar = Calendar.find(params[:id])
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)
    @calendar.project_id = current_project.id.to_i

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to calendars_path(current_project), notice: '일정이 등록되었습니다.' }
        format.json { render action: 'show', status: :created, location: @calendar }
      else
        format.html { render action: 'new' }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    @calendar = Calendar.find(params[:id])
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to calendars_path(current_project), notice: '일정이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    def current_project
      @current_project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:title, :c_data)
    end
end
