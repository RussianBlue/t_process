class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :password, :password_confirmation, :company, :name, :role_type, :celp_no

  validates_presence_of :company, :role_type, :celp_no
	validates_format_of :celp_no, :with => /^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/i, :multiline => true
	
  belongs_to :message
	has_many :user_projects
  has_many :projects, :through => 'user_projects'
  has_many :curriculums, :through => 'user_projects'

  #has_one :board

  ROLE_TYPES = ["트리짓", "고객사", "원고집필자", "검토자", "기타"]

  def self.my_curriculums(u, p)
    current_user = User.find(u)
    current_user_project = current_user.user_projects.find_by_project_id(p)
    logger.debug { "현재 프로젝트 파라미터 = #{p}" }
    logger.debug { "현재 유저프로젝트 = #{current_user_project}" }
    logger.debug { "현재 커리큘럼 = #{current_user_project.project.curriculums}" }
    @curriculums = current_user_project.project.curriculums
  end


  # current_user_project = current_user.user_projects.find_by_project_id(params[:project_id])
  #   logger.debug { "현재 프로젝트 파라미터 = #{params.inspect}" }
  #   logger.debug { "현재 유저프로젝트 = #{current_user_project}" }
  #   logger.debug { "현재 커리큘럼 = #{current_user_project.project.curriculums}" }
  #   @curriculums = current_user_project.project.curriculums
end
