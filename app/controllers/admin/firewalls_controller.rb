class Admin::FirewallsController < ApplicationController
  before_action :set_firewall, only: [:show, :edit, :update, :destroy]

  # GET /firewalls
  # GET /firewalls.json
  def index
    @firewalls = Firewall.all
  end

  # GET /firewalls/1
  # GET /firewalls/1.json
  def show
  end

  # GET /firewalls/new
  def new
    @firewall = Firewall.new
  end

  # GET /firewalls/1/edit
  def edit
  end

  # POST /firewalls
  # POST /firewalls.json
  def create
    @firewall = Firewall.new(firewall_params)

    respond_to do |format|
      if @firewall.save
        format.html { redirect_to firewalls_path, notice: '등록 되었습니다.' }
        format.json { render action: 'show', status: :created, location: @firewall }
      else
        format.html { render action: 'new' }
        format.json { render json: @firewall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /firewalls/1
  # PATCH/PUT /firewalls/1.json
  def update
    respond_to do |format|
      if @firewall.update(firewall_params)
        format.html { redirect_to firewalls_path, notice: '수정 되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @firewall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firewalls/1
  # DELETE /firewalls/1.json
  def destroy
    @firewall.destroy
    respond_to do |format|
      format.html { redirect_to firewalls_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_firewall
      @firewall = Firewall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def firewall_params
      params.require(:firewall).permit(:remote_ip, :ip_access)
    end
end
