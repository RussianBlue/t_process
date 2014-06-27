class Progress < ActiveRecord::Base
	belongs_to :curriculum
	has_many :progress_types
end