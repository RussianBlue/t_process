class Curriculum < ActiveRecord::Base
	has_many :user_projects
	has_many :users, :through => 'user_projects'
	has_many :projects, :through => 'user_projects'

	belongs_to :project
	has_many :progresses
	has_many :products

	validates_presence_of :total, :on => :create, :message => "총 차시수를 입력해 주세요."
	validates_presence_of :title, :on => :create, :message => "과정명을 입력해 주세요."

	validates_uniqueness_of :title, :on => :create, :message => "같은 이름의 과정명이 있습니다."
	validate :total, :length => { :maximum => 3 }

	validates_numericality_of :width, :greater_than => 100, :less_than => 1500, :message => "올바른 숫자를 입력해주세요."
	validates_numericality_of :height, :greater_than => 100, :less_than => 1000, :message => "올바른 숫자를 입력해주세요."

	#scope :res_by_project_id, lambda { |project_id| self.where(:project_id => project_id, :user_id => user_id) }
end
