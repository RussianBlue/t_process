require Rails.root.join('lib', 'devise', 'encryptors', 'md5')

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :encryptable, :encryptor => :md5

  #attr_accessible :email, :password, :password_confirmation, :company, :name, :role_type, :celp_no

  scope :user_name_to_id, -> (name) { where name: name }

  validates_presence_of :name
  validates_presence_of :company
  validates_presence_of :role_type
  validates_presence_of :celp_no 
	validates_format_of :celp_no, :with => /^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/i, :multiline => true
	
  belongs_to :message
  
  has_many :user_curriculums
  has_many :curriculums, :through => :user_curriculums

  #has_one :board

  ROLE_TYPES = ["트리짓", "고객사", "원고집필자", "검토자", "기타"]
  AUTHORIZE_TYPES = ["admin", "user", "guest"]
  SUPER_AUTHORIZE_TYPES = ["super", "admin", "user", "guest"]
  APPROVAL_TYPES = ["N", "Y"]

  def self.my_curriculums(u, p)
    current_user = User.find(u)
    current_user_project = current_user.user_projects.find_by_project_id(p)
    logger.debug { "현재 프로젝트 파라미터 = #{p}" }
    logger.debug { "현재 유저프로젝트 = #{current_user_project}" }
    logger.debug { "현재 커리큘럼 = #{current_user_project.project.curriculums}" }
    @curriculums = current_user_project.project.curriculums
  end

  def valid_password?(password)
    return false if encrypted_password.blank?
    Devise.secure_compare(password, self.encrypted_password)
  end

  def password_salt
    'no salt'
  end

  def password_salt=(new_salt)
  end

  def self.search(search)
    if search
      where("name LIKE ? OR email like ?", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  def password=(new_password)
    @password = new_password
    self.encrypted_password = @password
  end

  default_scope order('id DESC')
end