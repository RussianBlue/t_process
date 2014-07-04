class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_filter { |c| Authorization.current_user = c.current_user }

  include UrlHelper
  layout 'application'

  layout :layout_by_resource

  before_action :authenticate_user!
  before_filter :current_user_approval

  def current_user_approval
    if authenticate_user! 
      if current_user.approval == "N"
        respond_to do |format|
          flash[:alert] = "로그인 되었으나 해당 사용자는 승인되지 않았습니다."
          format.html { render template: "errors/error_approval", layout: 'layouts/error', status: status }
        end
      end

      if request.subdomain =~ /admin/ 
        if current_user.authorize =~ /super|admin/
          firewall = Firewall.find_by_remote_ip(current_user.current_sign_in_ip) if Firewall.exists?
          
          if firewall.ip_access == false
            render :text => '접속권한 없음', status: :bad_request
          end
        else
          redirect_to root_url(:subdomain => false) 
        end
      end
    end
  end

  #rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def session_remove
  	if session[:category_id] != nil
  		session.delete(:category_id)
  	end

  	if session[:curriculum_id] != nil
  		session.delete(:curriculum_id)
  	end
  end

  def session_create
    # 프로젝트 공통 게시판인 경우
    if params[:category_id] != nil
      session[:category_id] = params[:category_id]
      if params[:curriculum_id] == nil
        session.delete(:curriculum_id)
      end
    end

    if params[:curriculum_id] != nil
      session.delete(:curriculum_id)
      session[:curriculum_id] = params[:curriculum_id]
    end
  end

  def layout_by_resource
    if devise_controller? && request.subdomain =~ /admin/
      "admin"
    else
      if request.subdomain =~ /admin/
        "admin"
      else
        "application"
      end
    end
  end

  rescue_from Exception, with: lambda { |exception| render_error 500, exception }
  rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end
end
