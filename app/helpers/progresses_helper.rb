module ProgressesHelper
	def process_percent(lecture, progress_type_id)
  	total = lecture.total
  	percent = 0

  	# if total > 0
	  #   1.upto(total) do |lesson|
	  #   	percent += lecture.progresses.find_by_lesson_and_progress_type_id(lesson, progress_type_id).process
	  #   end

	  #   return percent / total
	  # else
	  # 	return 0
	  # end
  end
end
