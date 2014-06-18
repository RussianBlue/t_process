class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  helper_method :message_user

  def message_user(num)
    @message_user = User.find_by_celp_no(num)
  end

  # GET /messages
  # GET /messages.json
  def index
    @project = current_project

    @messages = current_project.messages.where(:user_id => current_user.id).order("id DESC").paginate(:page => params[:page], :per_page => 10)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @api_key = "NCS5354DDFD66C1C"
    api_secret = "324E34C96853118834644122C471EC11"

    @timestamp = Time.now.to_i
    @salt = SecureRandom.base64

    signature_data = @timestamp.to_s + @salt

    @signature = OpenSSL::HMAC.hexdigest('md5', api_secret, signature_data)
    @user = current_user

    to_list = @message.to.split(",").map(&:to_s)

    @userlists = []

    to_list.each do |num|
      user_celp_no = User.find_by_celp_no(num)
      if user_celp_no != nil
        @userlists.push(user_celp_no.name)
      else 
        @userlists.push(num)
      end
    end
  end

  # GET /messages/new
  def new
    @message = Message.new

    curriculum_ids = []
    current_project.curriculums.each do |curriculum|
      curriculum.users.each do |user|
        curriculum_ids.push(user)
      end
    end

    @userlists = User.where(:id => curriculum_ids)
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    curriculum_ids = []
    current_project.curriculums.each do |curriculum|
      curriculum.users.each do |user|
        curriculum_ids.push(user)
      end
    end

    @userlists = User.where(:id => curriculum_ids)
    @message = Message.new(message_params)

    @message.project_id = current_project.id
    @message.user_id = current_user.id
    @message.m_type = "SMS"
    @message.from = current_user.celp_no

    respond_to do |format|
      if @message.save
        format.html { redirect_to message_path(current_project, @message), notice: '메세지를 성공적으로 전송하였습니다.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def current_project
      @current_project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:project_id, :user_id, :m_type, :to, :from, :content)
    end
end
