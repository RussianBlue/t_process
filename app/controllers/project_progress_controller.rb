class ProjectProgressController < ApplicationController
	helper_method :progress_type, :progress_process, :split_to_length, :p_first_total, :p_second_total, :progress_process_name

  def index
  	session_remove()
  	@curriculums = current_project.curriculums
  end

  def progress_type(_id)
  	p = ProgressType.find(_id)
  end

  def progress_process_name(curriculum, ids)
    progress_ids = curriculum.progress_type_ids.split(",")

    return ProgressType.find(progress_ids[ids.to_i - 1].to_i).name
  end

  def progress_process(curriculum, ids)
  	total = curriculum.total
  	process_per = 0

    progress_ids = curriculum.progress_type_ids.split(",")

  	1.upto(total) do |i|
      curriculum.progresses.where(:lesson => i, :progress_type_id => progress_ids[ids.to_i - 1].to_i).each do |pp|
        process_per += pp.process
      end
  	end

  	return process_per / total
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
