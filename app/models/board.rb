class Board < ActiveRecord::Base
	belongs_to :user
	belongs_to :project

	has_many :board_categories, class_name: "BoardCategory", foreign_key: "category_id"

	has_attached_file :data

	validates_presence_of :pre_title, :on => :create, :message => "머릿말을 선택해 주세요."
	validates_presence_of :title, :on => :create, :message => "제목을 입력해 주세요."
  validates_length_of :title, :minimum => 1, :maximum => 100

	validates_presence_of :content, :on => :create, :message => "내용을 입력해 주세요."
  
  validates_attachment :data,
  :content_type => { :content_type => [/\Aimage\/.*\Z/, /\Aapplication\/.*\Z/, /\Aaudio\/.*\Z/, /\Atext\/.*\Z/, /\Avideo\/.*\Z/], 
  									 :message => '파일은 ZIP, PDF, 파워포인트, 엑셀, 워드, 한글 형식만 업로드 가능합니다.' },
  :size => { :in => 0..30.megabyte }

  def self.search(search)
    if search
      where("title LIKE ? OR content like ?", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  NOTICE_HEADS     = ['공지', '요청사항', '기타']
  STORYBOARD_HEADS = ['스토리보드', '요청사항', '피드백', '기타']
  SCRIPT_HEADS     = ['원고', '요청사항', '피드백', '기타']
  DOCUMENT_HEADS   = ['문서', '전달', '기타']
  OTHER_HEADS      = ["기타"]
end
