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
	validates :total, :length => { :maximum => 3 }

	#scope :res_by_project_id, lambda { |project_id| self.where(:project_id => project_id, :user_id => user_id) }
end
