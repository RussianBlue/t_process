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
    current_user_project = current_user.user_projects.find_by_project_id(params[:project_id])
    @curriculums = current_user_project.project.curriculums
  end

  def boolean_type_oxchange(arg)
    arg != true ? "X" : "O"
  end

  def current_project
    @current_project ||= Project.find(params[:project_id])
  end

  def current_curriculum
    @current_curriculum ||= Curriculum.find(params[:curriculum_id])
  end

  def new_tag(time)
    if time > (Date.today - 1)
      true
    else
      false
    end
  end
end
