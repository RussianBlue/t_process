module NoticesHelper

	def current_category
		@current_category = BoardCategory.find(session[:category_id].to_i)
	end
end
