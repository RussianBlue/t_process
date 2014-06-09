class Project < ActiveRecord::Base
	has_many :user_projects
	has_many :users, :through => 'user_projects'
	has_many :curriculums, :through => 'user_projects'

	has_many :boards

	has_many :curriculums
	has_many :messages

	validates_presence_of :title, :on => :create, :message => "프로젝트명을 입력해 주세요."
	validates_presence_of :years, :on => :create, :message => "년도를 선택해 주세요."

	validates_numericality_of :width, :greater_than => 100, :less_than => 1500, :message => "올바른 숫자를 입력해주세요."
	validates_numericality_of :height, :greater_than => 100, :less_than => 1000, :message => "올바른 숫자를 입력해주세요."

	YEARS = ["2014", "2013", "2012", "2011", "2010"]
	FINISH = [["N", false], ["Y", true]]
end