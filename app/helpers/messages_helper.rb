module MessagesHelper
	#메세지 번호 여러줄로 보이게 하기!
	def message_to_split(arg)
		aTo = arg.split(",")
		str = ""
		if aTo.length > 1
			0.upto(aTo.length - 1).each do |i|
				str += (aTo[i] + ",
				")
			end
		else
			str = aTo[0]
		end
		return str
	end
end
