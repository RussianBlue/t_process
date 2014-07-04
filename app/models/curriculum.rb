class Curriculum < ActiveRecord::Base
	has_many :user_curriculums
	has_many :users, :through => :user_curriculums
	belongs_to :project
	has_many :progresses
	has_many :products

	validates_presence_of :total, :on => :create, :message => "총 차시수를 입력해 주세요."
	validates_numericality_of :total, :greater_than => 1, :less_than => 50, :message => "1~50 사이의 올바른 숫자를 입력해주세요."
	validates_presence_of :title, :on => :create, :message => "과정명을 입력해 주세요."
	validates_uniqueness_of :title, :on => :create, :message => "이미 있는 과정입니다."
	validates_presence_of :location, :message => "공통 경로를 입력해 주세요."
	validates_presence_of :start, :message => "시작파일명을 입력해 주세요."
	
	validates_uniqueness_of :title, :on => :create, :message => "같은 이름의 과정명이 있습니다."
	validate :total, :length => { :maximum => 3 }
	
	validates_numericality_of :width, :greater_than => 100, :less_than => 1500, :message => "100~1500 사이의 올바른 숫자를 입력해주세요."
	validates_numericality_of :height, :greater_than => 100, :less_than => 1000, :message => "100~1000 사이의 올바른 숫자를 입력해주세요."

	#scope :res_by_project_id, lambda { |project_id| self.where(:project_id => project_id, :user_id => user_id) }

	def self.search(search)
    if search
      where("title LIKE ? OR c_code like ?", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end