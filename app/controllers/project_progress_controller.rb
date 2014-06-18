class ProjectProgressController < ApplicationController
	helper_method :progress_type, :progress_process, :split_to_length, :p_first_total, :p_second_total

  def index
  	session_remove()
  	@curriculums = current_project.curriculums
  end

  def progress_type(_id)
  	p = ProgressType.find(_id)
  end

  def progress_process(curriculum, ids)
  	total = curriculum.total
  	process = 0
  	1.upto(total) do |i|
  		process += curriculum.progresses.find_by_lesson_and_progress_type_id(i, ids).process.to_i
  	end
  	return process / total
  end

  def split_to_length(str)
  	p_total = str.split(",").map(&:to_i).length
  end

  def p_first_total(total)
    if total % 2 == 0
      return total/2
    else
      return total/2 + 1
    end
  end

  def p_second_total(total)
    if total % 2 == 0
      return total/2 + 1
    else
      return total/2 + 2
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def current_project
      @current_project = Project.find(params[:project_id])
    end
end
