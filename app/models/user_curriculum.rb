class UserCurriculum < ActiveRecord::Base
	belongs_to :user
	belongs_to :curriculum
end
