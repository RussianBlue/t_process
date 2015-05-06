module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def user_curriculums
    if current_user.authorize == "super" || current_user.authorize == "admin"
      @curriculums = current_project.curriculums
    else
      @curriculums = current_user.curriculums
    end
  end

  def current_board_title(board_id)
    @boards_id = BoardCategory.find(board_id.to_i)
  end

  def boolean_type_oxchange(arg)
    arg != true ? "X" : "O"
  end

  def current_project
    @current_project ||= Project.find(params[:project_id])
  end

  def current_curriculum
    @current_curriculum ||= Curriculum.find(session[:curriculum_id])
  end

  def new_tag(time)
    if time > Date.today - 1
      return true
    else
      return false
    end
  end
end
