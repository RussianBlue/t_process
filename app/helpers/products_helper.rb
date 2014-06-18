module ProductsHelper
	# 위젯의 초기값
	def set_group (count)
		defalut_state = "out"
	  if count==1
	    defalut_state = "in"
	  end      
	end

	# 그룹의 수
	def set_group_title (count)
		last_lesson = 0;
		1.upto(count) do |total|
			last_lesson += @group_lesson[total]
		end
		group_title = (20*(count-1)+1).to_s + "차시 ~ " + last_lesson.to_s + "차시"
	end

	def set_up_to(group)
		if group == 1
			return ((group-1)*10)
		else
			return (group-1)*20
		end
	end

	def set_up_end(group)
		# if group == 1
		# 	if @group_lesson[group] > 19
		# 		return (@group_lesson[group] / 2) - 1
		# 	else
		# 		return (@group_lesson[group] / 2)
		# 	end
		# else
			
		# end

		return (((group-1) * 20) + set_tables(@group_lesson[group])) - 1
	end

	def set_finish(group)
		if group == 1
			return @group_lesson[group].to_i - 1
		else
			return ((group-1) * 20) + @group_lesson[group] - 1
		end
	end

	def set_tables(total)
		if total % 2 == 0
			return total / 2
		else
			return (total / 2) + 1
		end
	end

	def itostr(arg)
		arg < 10 ? "0"+arg.to_s : arg.to_s
	end

	def contents_path(curriculum, lesson)
		curriculum.location + itostr(lesson+1) + "/" + curriculum.start
	end

	def get_content_width
		@curriculum.width
	end

	def get_content_width
		@curriculum.height
	end
end
