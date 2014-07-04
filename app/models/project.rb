class Project < ActiveRecord::Base
	has_many :boards
	has_many :calendars

	has_many :curriculums
	has_many :messages

	validates_presence_of :title, :on => :create, :message => "프로젝트명을 입력해 주세요."
	validates_presence_of :years, :on => :create, :message => "년도를 선택해 주세요."
	
	validates :title, uniqueness: true
  			
	#validates_presence_of :width, :on => :create, :message => "입력해 주세요."
	#validates_presence_of :height, :on => :create, :message => "입력해 주세요."

	#validates_numericality_of :width, :greater_than => 100, :less_than => 1500, :message => "100~1500 올바른 숫자를 입력해주세요."
	#validates_numericality_of :height, :greater_than => 100, :less_than => 1000, :message => "100~1000 올바른 숫자를 입력해주세요."

	YEARS = ["2014", "2013", "2012", "2011", "2010"]
	FINISH = [["N", false], ["Y", true]]

	def self.search(search)
    if search
      where("title LIKE ? OR years LIKE ?", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end