module ProjectDashboardHelper
	def current_dashboard_category(category)
		BoardCategory.find(category).name
	end
end
