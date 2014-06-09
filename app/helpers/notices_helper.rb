module NoticesHelper

	def current_category
		@current_category = BoardCategory.find(session[:category_id].to_i)
	end

	def notice_option
		case session[:category_id].to_s
	  when "1"
	    Board::NOTICE_HEADS
	  when "2"
	    Board::DOCUMENT_HEADS
	  when "3"
	    Board::DOCUMENT_HEADS
	  when "4"
	    Board::SCRIPT_HEADS
	  when "5"
	    Board::STORYBOARD_HEADS
	  else
	    Board::DOCUMENT_HEADS
	  end
	end
end
