class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

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

    # 과정별 게시판인 경우
    if params[:category_id].to_i >= 3 && params[:category_id].to_i <= 5
      session.delete(:curriculum_id)
      session[:curriculum_id] = params[:curriculum_id]
    end
  end

  #rescue_from Exception, with: lambda { |exception| render_error 500, exception }
  rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end
end
