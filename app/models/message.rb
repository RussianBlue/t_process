class Message < ActiveRecord::Base
	has_many :users
	belongs_to :project

	validates_presence_of :to, :message => "휴대폰 번호를 입력해 주세요."
	validates_presence_of :content, :message => "내용을 입력해 주세요."

	#validates_format_of :to, :with => /^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/i, :multiline => true, :message => "올바른 형식의 휴대폰 번호를 입력해 주세요."
end
